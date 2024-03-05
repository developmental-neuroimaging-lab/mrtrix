#!/bin/bash
# register MaCRUISE segmentation to FA map, convert MaCRUISE atlas to MRtrix format
# running locally
# by Meaghan Perdue
# Feb 2024

export bids=/Volumes/BIDS/CL_Preschool/derivatives/mrtrix
export atlas_in=/Volumes/catherine_team/Trainee_Folders/Long/MaCRUISE_atlas4connectome
export atlas_out=~/Projects/atlas_for_mrtrix

mkdir -p $atlas_out/${1}/${2}

# register MaCRUISE segmented T1 to FA map
flirt -in  $atlas_in/${3}_Seg_a.nii \
      -ref $bids/${1}/${2}/${1}_${2}_dwi_b750_tensor_fa_1mm.nii.gz \
      -out $atlas_out/${1}/${2}/${1}_${2}_SEG_reg2FA.nii.gz \
      -omat $atlas_out/${1}/${2}/${1}_${2}_T1_reg2FA.mat


labelconvert $atlas_out/${1}/${2}/${1}_${2}_SEG_reg2FA.nii.gz \
            $atlas_in/MaCRUISE_atlas_MRItrix.txt \
            $atlas_in/MaCRUISE_atlas_MRItrix.txt \
            $atlas_out/${1}/${2}/${1}_${2}_${3}_atlas.mif 
