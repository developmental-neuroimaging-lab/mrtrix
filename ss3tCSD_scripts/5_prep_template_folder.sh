#!/bin/bash
#generate study-specific unbiased FOD template (do this with just 30-40 subjects)
# this can be run from login node (no need to submit a slurm batch)
#first, create template folder and link FOD images and masks into sub-folders in the template folder

export mrtrix_out=/work/lebel_lab/mrtrix/data

mkdir -p $mrtrix_out/template/fod_input
mkdir $mrtrix_out/template/mask_input

subjects=template_subs.txt

while read i; do
    sh link.sh ${i}
    done <"$subjects"