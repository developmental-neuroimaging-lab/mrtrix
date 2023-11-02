#!/bin/bash
# Calculates voxel-wise Apparent Fiber Density (AFD) and tissue complexity metrics
# See Raffelt et al., 2012 & Calamante et al., 2015 NeuroImage papers
# FOD estimation and AFD calculation kept in subjects' native space (not MODULATED), Modulated approach should be applied if voxel-wise analysis is to be performed
# Note that it is usually better to follow the standard MRTrix3 fixel-based pipeline, Meaghan needs these voxel-wise measures for MRS-DWI analysis
# Meaghan Perdue - Nov. 2023

cd /mrtrix/${1}/${2}/ss3t_csd

# Calculate total AFD per voxel as the first spherical harmonic coefficient of the FOD
echo "-------- Calculate total AFD per voxel --------"
mrconvert wmfod_norm.mif -coord 3 0 total_afd_voxel.mif 


echo "-------- Calculating fixel-wise metrics --------"
fod2fixel wmfod_norm.mif fixel_native \
    -fmls_no_thresholds \
    -afd afd.mif \
    -peak_amp peak_amp.mif \
    -disp dispersion.mif

cd fixel_native

echo "-------- Calculating voxel-wise metrics  --------"
fixel2voxel -weighted afd.mif afd.mif mean voxel_afd_mean_weighted.nii.gz
#excluding other voxel-wise metrics for now, maps from test subjects seem noisy
#fixel2voxel afd.mif count voxel_fiber_count.nii.gz
#fixel2voxel afd.mif complexity voxel_fiber_complexity.nii.gz
#fixel2voxel -weighted dispersion.mif dispersion.mif mean voxel_dispersion_mean_weighted.nii.gz


