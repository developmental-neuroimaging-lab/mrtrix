#!/bin/bash
# Response estimation and FOD b2000 for CSD in MRtrix
# Prep data for FOD estimation
# run on ARC using mrtrix3 container
# by Meaghan Perdue
# Oct 2023

cd /mrtrix/${1}/${2}
mkdir ss3t_csd
mkdir tmp

#run response function estimation
echo "-------- Running response function estimation --------"
dwi2response dhollander ${1}_${2}_dwi_b2000_preprocessed.mif ss3t_csd/wm_response.txt ss3t_csd/gm_response.txt ss3t_csd/csf_response.txt -voxels ss3t_csd/voxels.mif  -info

#optionally view outputs, check shapes by tissue type (sphere vs. flattened) at each bval
#shview wm_response.txt

# Upsample b2000
echo "-------- Upsampling to 1mm voxel size to match T1s --------"
mrgrid ${1}_${2}_dwi_b2000_preprocessed.mif regrid -vox 1 ${1}_${2}_dwi_b2000_preprocessed_1mm.mif

# Create mask of upsampled DWI, using FSL BET because mrtrix dwi2mask function left big holes
echo "-------- Creating brainmask --------"
mrconvert ${1}_${2}_dwi_b2000_preprocessed_1mm.mif -coord 3 0 -axes 0,1,2 tmp/dwi_b2000_1mm_b0.nii.gz
bet tmp/dwi_b2000_1mm_b0.nii.gz tmp/dwi_b2000_2mm_bet -f .4 -m
mrconvert tmp/dwi_b2000_2mm_bet_mask.nii.gz ${1}_${2}_dwi_b2000_preprocessed_1mm_mask.mif
#cleanup
rm tmp/dwi_b2000*

