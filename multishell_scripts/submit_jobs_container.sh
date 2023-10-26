#!/bin/bash
# Script to loop over a list of subjects and submit jobs for processing in MRTrix3 container
# list path to processing script relative to container bindpath

subjects=subjlist.txt

while read i; do
    sbatch run_container_mrtrix.sh /mrtrix_ms/arc_scripts/1_preproc_multishell.sh ${i}
    done <"$subjects"