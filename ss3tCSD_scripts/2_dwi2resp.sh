#!/bin/bash
# Response estimation and FOD b2000 for CSD in MRtrix
# Prep data for FOD estimation
# run on ARC using mrtrix3 container
# by Meaghan Perdue
# Oct 2023

cd /mrtrix_out/${1}/${2}
mkdir ss3t_csd

#run response function estimation
echo "-------- Running response function estimation --------"
dwi2response dhollander ${1}_${2}_dwi_b2000_preprocessed_1mm.mif \
    ss3t_csd/wm_response.txt ss3t_csd/gm_response.txt ss3t_csd/csf_response.txt \
    -mask dwi_b2000_1mm_bet_mask.nii.gz \
    -voxels ss3t_csd/voxels.mif  -info

#optionally view outputs, check shapes by tissue type (sphere vs. flattened) at each bval
#shview wm_response.txt



