#!/bin/bash
# convert whole brain tractogram to connectome
# run on HPC
# by Meaghan Perdue
# Feb 2024

cd /mrtrix_out

# First, run labelconvert to configure MaCRUISE segmentation to mrtrix-compatible format
labelconvert ${3}_Seg_reg.nii MaCRUISE_atlas_MRItrix.txt \
            MaCRUISE_atlas_MRItrix.txt \
            ${1}_${2}_${3}_atlas.mif 


# Next, register subject-specific MaCRUISE segmentation to FA map
mrregister
