#!/bin/bash
# create template mask based on all subjects' masks
# run 1 job as: sbatch ../run_container_mrtrix.sh /mrtrix_src/ss3tCSD_scripts/8_make_template_mask.sh
# by Meaghan Perdue
# Feb 2024

cd /mrtrix_ms/out

mrmath template/warped_mask_input/*_mask_in_template_space.mif min template/template_mask_reading_subs.mif -datatype bit

echo "Check template mask for brain coverage!"
