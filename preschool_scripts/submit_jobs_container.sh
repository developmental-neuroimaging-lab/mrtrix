#!/bin/bash
# Script to loop over a list of subjects and submit jobs for processing in MRTrix3 container
# list path to processing script relative to container bindpath

subjects=b2000_subs.txt

while read i; do
    sbatch run_container_mrtrix.sh /mrtrix_src/1_preproc_b2000_arc.sh ${i}
    done <"$subjects"
