#!/bin/bash
#SBATCH --partition=cpu2021
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=04:00:00			      # Job should run up to 4 hours

# dMRI tensor estimation and calculation of metrics for b750 data
# run on HPC
# by Meaghan Perdue
# 20 April 2023
module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4
 

#set directory names based on directories in HPC
#output directory
export mrtrix_out=/home/meaghan.perdue/mrtrix

dwi2tensor $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_upsampled.mif $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_upsampled.mif -mask $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask_upsampled.mif

tensor2metric $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_upsampled.mif \
    -adc $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_md_upsampled.nii.gz \
    -fa $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_fa_upsampled.nii.gz \
    -ad $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_ad_upsampled.nii.gz \
    -rd $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_rd_upsampled.nii.gz \
    -vector $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_dec_upsampled.nii.gz \
    -mask $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask_upsampled.mif