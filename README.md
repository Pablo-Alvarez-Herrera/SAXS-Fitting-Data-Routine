Fitting Routines for Small-Angle X-ray Scattering (SAXS) Data

This repository contains two scripts that implement least-squares fitting routines for 
small-angle X-ray scattering (SAXS) data using the following models:
1. Spherical Core–Shell Model (main1_Spherical_Core_Shell_model)
This model includes:
- Porod term
- Form factor: core–shell spheres with uniform (constant) scattering length density in 
  the core and shell
- Structure factor: purely steric repulsion (hard-sphere interactions)
- Ornstein–Zernike structure factor
- Background term

See Eq. (1) of Ref. 1 for the full model definition.

2. Guinier–Porod Model (main2_Guinier_Porod_model)
This model includes:
- Guinier–Porod term
- Background term
See Eq. (2) of Ref. 1 for details.

* User Input
The user must provide:
- SAXS raw data in CSV format containing:
  - Momentum transfer 𝑞
  - Scattering intensity I(q)
  - Intensity uncertainty Δ𝐼(𝑞)
- Model parameters: for each fitting parameter, the user must specify:
  - Initial value
  - Final value
  - Step size for the iterative fitting procedure
    
* Script output

- The set of model parameters that minimizes the error (least-squares) function
- A plot comparing the experimental scattering intensity with the fitted model

Reference
[1] P. A. Alvarez Herrera et al., Soft Matter, 2025, 21, 4681.
DOI: 10.1039/d5sm00160a
