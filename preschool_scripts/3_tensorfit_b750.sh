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

dwi2tensor $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.mif $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor.mif -mask $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask.mif

tensor2metric $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor.mif \
    -adc $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_md.nii.gz \
    -fa $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_fa.nii.gz \
    -ad $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_ad.nii.gz \
    -rd $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_tensor_rd.nii.gz \
    -vector $mrtrix_out/${1}/${1}_${2}_dwi_b750_tensor_dec.nii.gz \
    -mask $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask.mif