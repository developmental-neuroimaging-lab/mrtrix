#!/bin/bash

# whole brain probabilistic tractography on b750 DTI data
# run on HPC
# by Meaghan Perdue
# Feb 2024

tckgen -algorithm Tensor_Prob -select 5000000 -seed_image /mrtrix_out/${1}/${2}/dwi_b750_1mm_bet_mask.nii.gz \
    /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_1mm.mif \
    /mrtrix_out/${1}/${2}/${1}_${2}_tensor_prob_wholebrain_5mil.tck
    