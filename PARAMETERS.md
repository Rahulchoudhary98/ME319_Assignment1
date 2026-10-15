# Linear model parameters

Values transcribed from the team's supplied paper, not independently measured values.

| Parameter | Value | Meaning |
|---|---:|---|
| `j` | 4 s | Normalized engine inertia coefficient |
| `b` | 1 | Normalized speed-drag coefficient |
| `k` | 4 | Normalized valve-to-torque gain |
| `KP` | 2 | Proportional gain |
| `KI` | 0.5 s^-1 | Integral gain |
| `a` | 0.45 s | Hydraulic/actuator coefficient |
| `c` | 1.05 | Hydraulic/actuator coefficient |
| `omega0` | 1 | Nominal normalized engine speed |
| `xv0` | 0.5 | Nominal valve opening fraction |

The characteristic polynomial is `D(s) = 1.8 s^3 + 4.65 s^2 + 9.05 s + 2`.

Disturbance transfers used by the script:

- Open-loop speed deviation: `e(s)/d(s) = -1/(j s + b)`
- Closed-loop speed deviation: `e(s)/d(s) = -s(a s + c)/D(s)`
- Closed-loop valve deviation: `v(s)/d(s) = (KP s + KI)/D(s)`

The open-loop comparison holds the valve at its nominal position. These are the transfer functions stated in the supplied report.
