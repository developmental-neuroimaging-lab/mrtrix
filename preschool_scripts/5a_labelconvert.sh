#!/bin/bash
# convert MaCRUISE atlas to MRtrix format
# running locally
# by Meaghan Perdue
# Feb 2024

export atlas_in=/Volumes/catherine_team/Trainee_Folders/Long/MaCRUISE_atlas4connectome
export atlas_out=~/Projects/atlas_for_mrtrix

labelconvert $atlas_in/${3}_Seg_reg.nii \
            $atlas_in/MaCRUISE_atlas_MRItrix.txt \
            $atlas_out/MaCRUISE_atlas_MRItrix.txt \
            $atlas_out/${1}_${2}_${3}_atlas.mif 
            