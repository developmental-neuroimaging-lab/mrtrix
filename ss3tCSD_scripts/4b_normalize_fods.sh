#!/bin/bash
# run joint bias field correction and intensity normalization on each tissue compartment 
# optionally extract CSD peaks for TractSeg
# Use masks b750_mask_upsampled from BET mask creation
# Run this via main MRTrix3 container
# by Meaghan Perdue
# Oct 2023

cd /mrtrix/${1}/${2}/ss3t_csd

echo "-------- Running bias field correction and intensity normalization on FODs --------"
mtnormalise -mask ../${1}_${2}_dwi_b2000_preprocessed_1mm_mask.mif \
    wmfod.mif wmfod_norm.mif \
    gm.mif gm_norm.mif \
    csf.mif csf_norm.mif \
    -info -nthreads 16

#extract CSD peaks for TractSeg (optional)
sh2peaks -mask ../${1}_${2}_dwi_b2000_preprocessed_1mm_mask.mif wmfod_norm.mif wmfod_norm_peaks.nii.gz -nthreads 16