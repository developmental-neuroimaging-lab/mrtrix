#!/bin/bash
# loop over list of subjects/sessions to sync data to to ARC

subjects=multishell_subs.txt

while read i; do
    sh rsync_ms2arc.sh ${i}
    done <"$subjects"