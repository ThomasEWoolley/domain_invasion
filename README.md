# Codes and data archive for "Accounting for dimensional differences in stochastic domain invasion with applications to precancerous cell removal"
We consider a specific form of domain invasion that is an abstraction of pancreatic tissue eliminating precancerous mutant cells through juxtacrine signalling. The model is explored discretely, continuously, stochastically and deterministically, highlighting unforeseen nonlinear dependencies on the dimension of the solution domain. Specifically, stochastically simulated populations invade with a dimension dependent wave speed that can be over twice as fast as their deterministic analogues. Although the wave speed can be analytically derived in the cases of small domains, the probabilistic state space grows exponentially and, thus, we use numeric simulation and curve fitting to predict limiting dynamics.

Note that the Stochastic simulation algorithms need the following software to run
Nezar (2022). Gillespie Stochastic Simulation Algorithm [https://github.com/nvictus/Gillespie](https://github.com/nvictus/Gillespie), GitHub. Retrieved January 6, 2022. 

## Folder contents
- 1D_sims

There are a number of codes and data files in here all running variations of the same one-dimensional invasion simulation. The mat files are the scripts and the m files are the output data files.

The structure of the codes is always the same, there is an IC.m file which sets up the initial conditions for a specific simulation. For example "Hundred_species_sims.m" simulates a one-dimensional invasion over 300 boxes, one hundred times (to allow for averaging). These simulations are saved in "Hundred_runs_300_space.mat". Each code will specify the appropriate output file one it is opened.

The "aligner" scripts post-process the data and average across the simulations.

The "comparing" scripts compare the data with the algebraic solutions.

- 2D_sims

These are the 2D simulations of small of width that are just about tractable through algebraic approaches. The simulations are the 2D analogues of the codes in 1D_sims. All that is changed is the widths and lengths of the domains.

- Par_2D_sims folders

The 7 folders starting with Par_2D_sims are the large 2D simulation with different boundary conditions and/ or different initial conditions. Their individual titles should specify what the contents of the folder contains. These simulations are the parallelised analogues of the 1D simulations

- Deterministic_stochastic_travelling_waves

Contains scripts and data from the accompanying deterministic solutions. The solutions are generated either as large coupled ODE networks using ode45 or as a pde using pdepe. See text for details.

- Codes_with_prism_data

The experimental data from [EPHA2-dependent outcompetition of KRASG12D mutant cells by wild-type neighbors in the adult pancreas](https://www.sciencedirect.com/science/article/pii/S096098222100467X) can be found in the subfolder "Prism_data".

Data_plotting.m processes and plots the data, whilst Rate_fitter.m  fits the free invasion rate parameter "r" to the data.

- Maths_investigation

This folder can be generally ignored. It contains various tests that formed the background of the work and is kept for legacy reasons.




