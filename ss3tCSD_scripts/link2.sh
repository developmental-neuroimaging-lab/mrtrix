#!/bin/bash
symbolic link warped masks to template folder

cd /work/lebel_lab/mrtrix/data

ln -sr ${1}/${2}/ss3t_csd/dwi_mask_in_template_space.mif template/warped_mask_input/${1}_${2}_mask_in_template_space.mif