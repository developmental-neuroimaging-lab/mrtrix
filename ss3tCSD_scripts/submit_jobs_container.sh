#!/bin/bash
# Script to loop over a list of subjects and submit jobs for processing in MRTrix3 container
# list path to processing script relative to container bindpath

#subjects=b2000_subs.txt
subjects=tmp.txt

# while read i; do
#     sbatch ../run_container_mrtrix.sh /mrtrix/src/ss3tCSD_scripts/4b_normalize_fods.sh ${i}
#     done <"$subjects"

#Uncomment this to submit dwi2fod to run in mrtrix3tissue for single-shell 3 tissue CSD
while read i; do
    sbatch ../run_container_ss3tmrtrix.sh /mrtrix/src/ss3tCSD_scripts/4_dwi2fod.sh ${i}
    done <"$subjects"