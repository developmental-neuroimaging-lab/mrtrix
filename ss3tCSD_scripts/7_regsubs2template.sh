#!/bin/bash
# Register subject's FODs to FOD template and warp masks to template space
# by Meaghan Perdue
# Feb 2024


cd /mrtrix_out/${1}/${2}/ss3t_csd
mrregister wmfod_norm.mif -mask1 ../${1}_${2}_dwi_b2000_1mm_bet_mask.nii.gz /mrtrix_out/template/wmfod_template.mif -nl_warp subject2template_warp.mif template2subject_warp.mif -nthreads 16 
mrtransform ../${1}_${2}_dwi_b2000_1mm_bet_mask.nii.gz -warp subject2template_warp.mif -interp nearest -datatype bit dwi_mask_in_template_space.mif -nthreads 16 

