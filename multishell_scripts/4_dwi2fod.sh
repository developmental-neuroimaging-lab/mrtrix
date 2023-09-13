#!/bin/bash
#SBATCH --partition=cpu2021 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=01:00:00			      # Job should run up to 6 hours

# Run FOD estimation using group average response functions
# Use masks b750_mask_upsampled from BET mask creation
# Normalize FODs
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4
module load ants/2.3.1

export mrtrix_out=/work/lebel_lab/mrtrix
export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/${1}/${2}

# dwi2fod msmt_csd ${1}_${2}_dwi_multishell.mif \
#     $mrtrix_ms/group_average_response_wm.txt wmfod.mif \
#     $mrtrix_ms/group_average_response_gm.txt gm.mif \
#     $mrtrix_ms/group_average_response_csf.txt csf.mif \
#     -mask $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask_upsampled.mif \
#     -info -nthreads 16

# mrconvert -coord 3 0 wmfod.mif - | mrcat csf.mif gm.mif - vf.mif  
#outputs the rgb visualization of csd ellipsoids
 
#display tissue signal contribution map green=GM, blue=WM, red=CSF
#mrview vf.mif 
#display WM FODs on T1w
#mrview T1w_reg2dwi.mif -odf.load_sh wmfod.mif

# Extract first volume from mask for subsequent analysis
mrconvert $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask_upsampled.mif -coord 3 0 -axes 0,1,2 mask.mif

#run joint bias field correction and intensity normalization on each tissue compartment 
mtnormalise -mask mask.mif \
    wmfod.mif wmfod_norm.mif \
    gm.mif gm_norm.mif \
    csf.mif csf_norm.mif \
    -info -nthreads 16

#extract CSD peaks for TractSeg (optional)
sh2peaks -mask mask.mif wmfod_norm.mif wmfod_norm_peaks.nii.gz -nthreads 16
