#!/bin/bash
#generate study-specific unbiased FOD template (ok to do this with just 30-40 subjects)


export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

#first, create template folder and link FOD images and masks into sub-folders in the template folder

cd $mrtrix_ms

mkdir -p template/fod_input
mkdir template/mask_input

subjects=arc_scripts/subs_for_group_avg.txt

while read i; do
    sh link.sh ${i}
    done <"$subjects"
	