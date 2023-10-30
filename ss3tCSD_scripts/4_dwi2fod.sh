#!/bin/bash
# Run FOD estimation using group average response functions
# Use masks b750_mask_upsampled from BET mask creation
# This script MUST be run via the mrtrix3Tissue container, not the standard MRTrix container, in order to use the ss3t_csd_beta1 method!
# by Meaghan Perdue
# Oct 2023

cd /mrtrix/${1}/${2}

# Perform SS3T-CSD
echo "-------- Running single-shell 3-tissue CSD --------"
ss3t_csd_beta1 -mask ${1}_${2}_dwi_b2000_preprocessed_1mm_mask.mif -info -nthreads 16 \
    ${1}_${2}_dwi_b2000_preprocessed_1mm.mif  \
    /mrtrix/ss3t_group_average/group_average_response_wm.txt ss3t_csd/wmfod.mif \
    /mrtrix/ss3t_group_average/group_average_response_gm.txt ss3t_csd/gm.mif \
    /mrtrix/ss3t_group_average/group_average_response_csf.txt ss3t_csd/csf.mif 

mrconvert -coord 3 0 ss3t_csd/wmfod.mif - | mrcat ss3t_csd/csf.mif ss3t_csd/gm.mif - ss3t_csd/vf.mif  
#outputs the rgb visualization of csd ellipsoids
 
#display tissue signal contribution map green=GM, blue=WM, red=CSF
#mrview vf.mif 
#display WM FODs on T1w
#mrview T1w_reg2dwi.mif -odf.load_sh wmfod.mif


