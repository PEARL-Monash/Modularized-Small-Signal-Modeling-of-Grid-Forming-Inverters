# Modularized-Small-Signal-Modeling-of-Grid-Forming-Inverters


## Overview

This repository is a power system toolkit for the small-signal modeling of Grid-Forming Inverters (GFMIs). 
It contains the full development of the small-signal model of different types of GFMIs and further analysis
of the models, including eigenvalue analysis. 

The files in this repository intend to walk you to build a complete small-signal model of a GFMI built 
from scratch and to conduct analysis with the small-signal models.

## Citing this repository

In case you use files of this repository for any educational material or publication, we would appreciate 
it if you can cite the following article:

> Sohail A. Ali, Paul Serna-Torre, Patricia Hidalgo-Gonzalez, Mehdi Ghazavi Dozein, and Behrooz Bahrani, 
"Modularized Small-Signal Modeling of Grid-Forming Inverters", IEEE Open Access, 2025

You can find the corresponding citation (.bib) in the IEEE website.

## Get Started with this Repository

It is strongly recommended you can read the paper so that you can understand the modeling and simulation 
behind this repository.

You can begin using the files of this repository by following these steps:

1.  Install [Matpower](https://matpower.org/) if you do not have already have it installed in your computer. 

    - Make sure that Matpower is in your Matlab path. To this purpose, when you install Matpower, choose the option 3.
    - Matpower is required to obtain a power flow solution which is the initial condition to generate the small-signal
    models.
    - The files of this repository runs Matpower internally. 

2.  Save the folder "Functions" in your Matlab path. 

    - This folder contains functions that are used across several files.

3.  Go to the folder "Grid_Forming_Inverters". You will see several folders that correspond to each GFMI model, e.g., droop, virtual
    synchronous machines. Please refer to the paper to understand each of the models.

4.  Go to one folder, for example, "Compensated_Generalized_Virtual_Synchronous_Machine". The files that you can run have the
    extension .mlx. 

5.  Run the .mlx file that has the name of the GFMI model. For example, if you are in the folder 
    "Compensated_Generalized_Virtual_Synchronous_Machine", then the file is "CGVSG.mlx". This mlx file
    generate the state-space matrices A, B, C, D of the small-signal model of the GFMI. After running the file, you will 
    see that a .mat file generated. This .mat file contains the state-space matrices in symbols (not numbers).

    -   You will see that a .mlx file is self-explanatory and can walk you to understand how the model is generated step-by-step.
    -   Once you have the state-space matrices of the small-signal model of a GFMI, then you can conduct more analysis with it, 
        as we do in the next step.

6.  Run any other .mlx file, for example, "CGVSG_XR_EA.mlx". This file runs a eigenvalue analysis. Note that this file uses
    the state-space matrices of the small-signal model generated in the step 5. You will output files after running this file, 
    for example, svg figures. 

    -   As this step 6 conducts a numerical analysis, make sure you have the file "Parameters.m" in the same folder of the .mlx file. 
        The "Parameter.m" file contains the numerical parameters, such as gains of the control schemes of the GFMI. 

## Description of executable files in this repository.

1. SMIB_PowerFlow.m: Computes a power flow solution for the GFMI connected to an infinite bus using Matpower.
2. Parameters.m: Contains the numerical parameters for the GFMI models.
3. CGVSG.mxl: Generates the symbolic small-signal model for a Compensated generalized virtual synchronous generator.
4. Droop_Model.mlx: Generates the symbolic small-signal model for a Droop-based GFMI.
5. LPF_Model.mlx: Generates the symbolic small-signal model for a Low-pass-filter-based GFMI.
6. VSG_Model.mlx: Generates the symbolic small-signal model for a Virtual synchronous generator.
7. VSG_Model_VI.mlx: Generates the symbolic small-signal model for a Virtual Synchronous generator with algebraic virtual impedance.
8. VSG_model_No_CC.mlx: Generates the symbolic small-signal model for a Virtual Synchronous generator with no current controller. This is reduced model version of
the VSG_Model.
9. VSG_model_No_VC.mlx: Generates the symbolic small-signal model for a Virtual Synchronous generator with no voltage controller. This is reduced model version of
the VSG_Model.
10. CGVSG_XR_EA.mlx: Conducts the eigenvalue analysis for a CGVSG.

## Run into some issues?

If you have any question or run into some issues, please contact: sohail.ali[at]monash.edu, or psernatorre[at]ucsd.edu. 
