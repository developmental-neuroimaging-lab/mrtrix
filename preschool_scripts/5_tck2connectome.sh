#!/bin/bash
# convert whole brain tractogram to connectome
# must run labelconvert script first (either locally on on HPC)
# run on HPC
# by Meaghan Perdue
# Feb 2024

cd /mrtrix_out/

# generate connectome matrix using macruise atlas and whole brain tractogram
tck2connectome ${1}/${2}/${1}_${2}_tensor_prob_wholebrain_1mil.tck \
    ${1}/${2}/${1}_${2}_${3}_atlas.mif \
    ${1}/${2}/${1}_${2}_${3}_connectome.csv \
    -zero_diagonal \
    -out_assignments ${1}/${2}/${1}_${2}_${3}_assignments.txt
