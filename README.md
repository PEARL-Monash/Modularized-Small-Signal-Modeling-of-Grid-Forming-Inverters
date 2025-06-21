# Modularized-Small-Signal-Modeling-of-Grid-Forming-Inverters


## Overview

This repository provides a comprehensive power system toolkit for the modular small-signal modeling of Grid-Forming Inverters (GFMIs). It implements the complete development of small-signal models for various GFMI control strategies, along with analytical tools for detailed stability studies including eigenvalue analysis.

The files in this repository are designed to guide you through building small-signal models of GFMIs from first principles, and enable you to conduct systematic analyses of these models under a wide range of control and grid conditions.

## Citing this repository

If you find this repository helpful in your own research or modeling activities, we would be sincerely grateful if you consider citing the following publication:

> Sohail A. Ali, Paul Serna-Torre, Patricia Hidalgo-Gonzalez, Mehdi Ghazavi Dozein, and Behrooz Bahrani, 
"Modularized Small-Signal Modeling of Grid-Forming Inverters", IEEE Open Access, 2025

You can find the corresponding citation (.bib) on the IEEE website.

## Get Started with this Repository

While the repository is self-contained, we strongly recommend reading the accompanying paper to fully understand the modeling framework and analysis procedures implemented here.

You can begin using the files of this repository by following these steps:

1.  Install [Matpower](https://matpower.org/) if you do not have it already installed on your computer. 

    - During MATPOWER installation, select option 3 to ensure proper integration.
    - Matpower is required to obtain a power flow solution which is used to calculate linear operating point of the small-signal
    models. (It is important to perform power flow when you vary circuit parameters, as these affect your operating point and consequently your eigenvalues)

2.  Go to the folder "Generate_SSM". You will find all the models developed in our paper. It contains several MATLAB .mlx and .mat files that correspond to each model. For example, running the "VSG_model.mlx" does the following:
    - Builds subsystems, algebraic loops and performs the Component Connection Method (CCM) to provide symbolic model of the VSG.
    - This model is saved as a .mat file and can be used for eigenvalue analysis (Part 3) and validation with an EMT model.
    - The same process is repeated for all models

3.  Go to the folder "EigenAnalysis". This file helps you study how the stability of your system changes when you adjust control or grid parameters.
    - Copy the symbolic models you created in Step 2 (e.g Unified_VSG.mat) into this folder.
    - The scripts will convert all your variables in the symbolic models into numeric with values in the "Parameters.m" except for the parameter you intend to vary.
    - To help you get started, the provided files can vary feedforward, inertia, short-circuit ratio and XR ratio for VSG.
    - You can can do this for any model by simplying loading another model in the folder.

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
9. VSG_model_No_VC.mlx: Generates the symbolic small-signal model for a Virtual Synchronous generator without voltage or current controller. This is reduced model version of
the VSG_Model.
10. VSG_SCR.mlx: Conducts the eigenvalue analysis for a VSG for grid strength variation.

## Run into some issues?

If you have any question or run into some issues, please contact: sohail.ali[at]monash.edu, or psernatorre[at]ucsd.edu. 
