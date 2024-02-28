#!/bin/bash	      

#Compute fiber cross-section (FC), logFC, and Fiber density and cross-section (FDC) metrics
#script by Meaghan Perdue, Aug 2023

cd /mrtrix_out/template

tracts=("AF_left" "AF_right" "SLF_III_left" "SLF_III_right" "ILF_left" "ILF_right" "IFO_left" "IFO_right")

for i in ${tracts[@]}; do
    echo ${1} ${2} \
    $(mrstats -output mean -output std -mask tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif fd/${1}_${2}.mif) \
    $(mrstats -output mean -output std -mask tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif log_fc/${1}_${2}.mif) \
    $(mrstats -output mean -output std -mask tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif fdc/${1}_${2}.mif) >> ${i}_stats.txt
    done  





