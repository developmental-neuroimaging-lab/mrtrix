#!/bin/bash

# dMRI tensor estimation and calculation of metrics for b750 data
# run on HPC
# by Meaghan Perdue
# 20 April 2023

dwi2tensor /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_1mm.mif /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_1mm.mif \
    -mask /mrtrix_out/${1}/${2}/dwi_b750_1mm_bet_mask.nii.gz

tensor2metric /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_1mm.mif \
    -adc /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_md_1mm.nii.gz \
    -fa /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_fa_1mm.nii.gz \
    -ad /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_ad_1mm.nii.gz \
    -rd /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_rd_1mm.nii.gz \
    -vector /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_dec_1mm.nii.gz \
    -mask /mrtrix_out/${1}/${2}/dwi_b750_1mm_bet_mask.nii.gz