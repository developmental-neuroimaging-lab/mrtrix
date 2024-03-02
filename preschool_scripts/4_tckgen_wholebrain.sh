#!/bin/bash

# whole brain probabilistic tractography on b750 DTI data
# run on HPC
# by Meaghan Perdue
# Feb 2024

#generate whole brain tractogram with 5 million streamlines

tckgen -algorithm Tensor_Prob -select 1000000 -nthreads 16 \
    -seed_image /mrtrix_out/${1}/${2}/dwi_b750_1mm_bet_mask.nii.gz \
    -mask /mrtrix_out/${1}/${2}/dwi_b750_1mm_bet_mask.nii.gz \
    /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_1mm.mif \
    /mrtrix_out/${1}/${2}/${1}_${2}_tensor_prob_wholebrain_1mil.tck

# downsample to 100k streamlines for viewing in mrview
tckedit -number 100k -nthreads 16 \
    /mrtrix_out/${1}/${2}/${1}_${2}_tensor_prob_wholebrain_1mil.tck \
    /mrtrix_out/${1}/${2}/${1}_${2}_tensor_prob_wholebrain_100k.tck