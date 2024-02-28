#!/bin/bash	      

#warp subjects' FOD images into template space
#segment each FOD lobe (computes AFD per fixel)
#reorient fixels in template space based on local transformation at each voxel
#script by Meaghan Perdue, Feb 2024

cd /mrtrix_out/${1}/${2}/ss3t_csd

mrtransform wmfod_norm.mif -warp subject2template_warp.mif -reorient_fod no fod_in_template_space_NOT_REORIENTED.mif -nthreads 16 
fod2fixel -mask /mrtrix_out/template/template_mask.mif fod_in_template_space_NOT_REORIENTED.mif fixel_in_template_space_NOT_REORIENTED -afd fd.mif -nthreads 16 
fixelreorient fixel_in_template_space_NOT_REORIENTED subject2template_warp.mif fixel_in_template_space -nthreads 16 

#After this step, the fixel_in_template_space_NOT_REORIENTED folders can be safely removed.
