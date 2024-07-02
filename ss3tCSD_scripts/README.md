# Code for running single-shell-3-tissue Constrained Spherical Deconvolution (ss3t-CSD) on Preschool b2000 DWI data
Pipeline developed by Meaghan Perdue, Fall 2023

All Preschool b2000 data with sufficient quality (based on EddyQC parameters average relative motion <.7 mm cut-off) have been processed through this pipeline. 

This folder contains scripts for running ss3t-CSD via MRTrix3 <https://mrtrix.readthedocs.io/en/latest/> and MRTrix3tissue <https://3tissue.github.io/> via the ARC. \
Main scripts are run via the MRTrix3 container (running version 3.0.4), with the execption of FOD estimation (4_dwi2fod.sh) which is run via the MRtrix3Tissue container. 

This code follows the Fixel-Based Analysis pipeline (https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/mt_fibre_density_cross-section.html), with adaptations for single-shell data with NO reverse phase encoding. Inputs are preprocessed b2000 DWI images. 

For tract-based metrics (Fiber Density, Fiber Cross-section, Fiber Density & Cross-section), TractSeg <https://github.com/MIC-DKFZ/TractSeg> was run on the study-specific template, and tracts were converted to fixel-masks to extract mean values across tracts for each participant. MP ran TractSeg and pulled stats for the following tracts (bilaterally): 
- Arcuate Fasciculus
- Superior Longitudinal Fasciculus-III (ventral branch)
- Inferior Longitudinal Fasciulus
- Inferior Fronto-Occipital Fasciulus
Additional tracts can be pulled using **run_tractseg_on_template.sh**, comment out lines 14-26, and only run the Tracking step, indicating the bundles you want to tract on line 31 using bundle names according to the TractSeg Github documentation linked at the top of this document.

