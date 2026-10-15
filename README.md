# ME319 Assignment 1 — Water-Inventory Governor

This folder contains the team's supplied six-page paper (five technical pages plus the one-page mandatory AI appendix) and a reproducibility script based on the linear transfer functions and parameter values printed in that paper.

## Contents

- `ME319_Assignment1_IEEE_Paper_with_AI_Appendix.pdf` — supplied paper PDF.
- `src/simulate_governor.m` — MATLAB/GNU Octave script for the two prescribed normalized load steps.
- `results/` — CSV files are generated here when the script runs.
- `figures/` — PNG plots are generated here when the script runs.
- `PARAMETERS.md` — model parameters and conventions.

## Reproduce the linear simulations

1. Install GNU Octave and its `control` package, or use MATLAB with Control System Toolbox.
2. Open a terminal in the `src` directory.
3. Run `octave --quiet simulate_governor.m` (or run the script in MATLAB).
4. The script writes CSV response data to `results/`, plots to `figures/`, and prints the closed-loop poles.

The disturbance variable is `d = TL/TL0 - 1`. The two runs use `d = +0.3` and `d = -0.3`, starting from normalized speed `omega = 1` and valve opening `xv = 0.5`.

## Important verification notes

- This script reproduces the **linear transfer-function** simulation only. It does not recreate the paper's separately described nonlinear-orifice simulation or 64-corner parameter sweep.
- Review the generated plots and numerical metrics against the final PDF before submission.
- The paper currently says the public repository URL is pending. After creating a public GitHub repository, replace that placeholder in the paper with the actual URL and re-export the PDF.
- Do not claim the repository is public until it has actually been created and checked.
- Each team member must submit the official confidential peer-evaluation form independently through the course process. It is not included here because the official form was not provided among the uploaded files.
