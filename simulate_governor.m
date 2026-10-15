% ME319 Assignment 1: Water-Inventory Governor
% Reproduces the linear load-step responses from the transfer functions
% reported in the submitted paper. Requires GNU Octave + control package
% (or MATLAB with Control System Toolbox).
clear; close all; clc;

% Normalized model parameters reported in the paper
j = 4.0;       % normalized engine inertia coefficient [s]
b = 1.0;       % normalized speed-drag coefficient
k = 4.0;       % normalized valve-to-torque gain
KP = 2.0;      % proportional gain
KI = 0.5;      % integral gain [1/s]
a = 0.45;      % actuator/hydraulic coefficient [s]
c = 1.05;      % actuator/hydraulic coefficient
xv0 = 0.5;     % nominal valve opening
w0 = 1.0;      % nominal normalized speed

% Closed-loop characteristic polynomial:
% D(s) = j*a*s^3 + (j*c+b*a)*s^2 + (b*c+k*KP)*s + k*KI
D = [j*a, j*c+b*a, b*c+k*KP, k*KI];

% Use transfer functions for disturbance-to-output responses.
% d = TL/TL0 - 1; e = omega - 1; v = xv - xv0.
if exist('OCTAVE_VERSION', 'builtin')
  pkg load control;
end
s = tf('s');
G_open_e_d = -1/(j*s+b);
% Construct polynomial transfer functions directly for Octave/MATLAB.
G_closed_e_d = tf([-a, -c, 0], D);
G_closed_v_d = tf([KP, KI], D);

% 80 s simulation, as described in the report.
t = (0:0.002:80)';
load_steps = [0.3, -0.3];
labels = {'load_increase_30pct', 'load_decrease_30pct'};
if ~exist('../results','dir'), mkdir('../results'); end
if ~exist('../figures','dir'), mkdir('../figures'); end

for n = 1:numel(load_steps)
  d = load_steps(n)*ones(size(t));
  e_open = lsim(G_open_e_d, d, t);
  e_closed = lsim(G_closed_e_d, d, t);
  v_closed = lsim(G_closed_v_d, d, t);
  omega_open = w0 + e_open;
  omega_closed = w0 + e_closed;
  xv_open = xv0*ones(size(t));
  xv_closed = xv0 + v_closed;

  out = [t, d, omega_open, omega_closed, xv_open, xv_closed];
  csvfile = fullfile('../results', [labels{n}, '.csv']);
  fid = fopen(csvfile,'w');
  fprintf(fid,'time_s,disturbance_d,omega_open_loop,omega_closed_loop,xv_open_loop,xv_closed_loop\n');
  fclose(fid);
  dlmwrite(csvfile, out, '-append', 'delimiter', ',', 'precision', '%.10g');

  figure('visible','off');
  subplot(2,1,1);
  plot(t,omega_open,'--',t,omega_closed,'-','LineWidth',1.3); grid on;
  ylabel('Normalized speed, omega'); legend('Open loop','Closed loop','Location','best');
  if n == 1, title('30% increase in load torque: 1 to 1.3');
  else, title('30% decrease in load torque: 1 to 0.7'); end
  subplot(2,1,2);
  plot(t,xv_open,'--',t,xv_closed,'-','LineWidth',1.3); grid on;
  xlabel('Time (s)'); ylabel('Valve opening, x_v');
  legend('Open loop','Closed loop','Location','best');
  print(fullfile('../figures',[labels{n},'.png']),'-dpng','-r180');
  close;
end

fprintf('Characteristic polynomial coefficients: '); fprintf('%.6g ', D); fprintf('\n');
fprintf('Closed-loop poles (1/s):\n'); disp(roots(D));
fprintf('Saved CSV results under ../results and plots under ../figures.\n');
