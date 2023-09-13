#!/bin/bash
#generate study-specific unbiased FOD template (ok to do this with just 30-40 subjects)

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

#first, create template folder and link FOD images and masks into sub-folders in the template folder

cd $mrtrix_ms
mkdir template/warped_mask_input

subjects=arc_scripts/reading_wm_subs.txt

while read i; do
    sh arc_scripts/link2.sh ${i}
    done <"$subjects"