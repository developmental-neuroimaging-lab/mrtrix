#!/bin/bash
# Convert tracts segmented from tractseg to fixel maps
# convert tract to fixelmaps (tract density map of number of streamlines passing through each fixel)
# threshold fixels with a minimum of 5 streamlines and binarize
# set up text files for stats output
#script by Meaghan Perdue, Feb 2024


cd /mrtrix_out/template
mkdir tractseg_output/fixel_masks

tracts=("AF_left" "AF_right" "SLF_III_left" "SLF_III_right" "ILF_left" "ILF_right" "IFO_left" "IFO_right")

for i in ${tracts[@]}; do
    tck2fixel tractseg_output/TOM_trackings/${i}.tck fixel_mask tractseg_output/fixel_masks/${i} ${i}.mif 
    mrcalc tractseg_output/fixel_masks/${i}/${i}.mif 5 -ge tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif
    echo subj_id    ses_id  ${i}_fd_m 	${i}_fd_sd 	${i}_log_fc_m   ${i}_log_fc_sd  ${i}_fdc_m  ${i}_fdc_sd	>> ${i}_stats.txt
    done

# visual check
#fixel2tsf tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif tractseg_output/TOM_trackings/${i}.tck tractseg_output/fixel_masks/${i}/${i}.tsf