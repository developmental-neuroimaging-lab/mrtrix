#!/bin/bash
# Run FOD estimation using group average response functions
# Use masks b750_mask_upsampled from BET mask creation
# This script MUST be run via the mrtrix3Tissue container, not the standard MRTrix container, in order to use the ss3t_csd_beta1 method!
# by Meaghan Perdue
# Oct 2023

cd /mrtrix_out/${1}/${2}

# Perform SS3T-CSD
echo "-------- Running single-shell 3-tissue CSD --------"
ss3t_csd_beta1 -mask dwi_b2000_1mm_bet_mask.nii.gz -info -nthreads 16 \
    ${1}_${2}_dwi_b2000_preprocessed_1mm.mif  \
    /mrtrix_out/ss3t_group_average/group_average_response_wm.txt ss3t_csd/wmfod.mif \
    /mrtrix_out/ss3t_group_average/group_average_response_gm.txt ss3t_csd/gm.mif \
    /mrtrix_out/ss3t_group_average/group_average_response_csf.txt ss3t_csd/csf.mif 

#mrconvert -coord 3 0 ss3t_csd/wmfod.mif - | mrcat ss3t_csd/csf.mif ss3t_csd/gm.mif - ss3t_csd/vf.mif  
#optionally outputs the rgb visualization of csd ellipsoids
 
cd ss3t_csd
echo "-------- Running bias field correction and intensity normalization on FODs --------"
mtnormalise -mask ../dwi_b2000_1mm_bet_mask.nii.gz \
    wmfod.mif wmfod_norm.mif \
    gm.mif gm_norm.mif \
    csf.mif csf_norm.mif \
    -info -nthreads 16

#display tissue signal contribution map green=GM, blue=WM, red=CSF
#mrview vf.mif 




