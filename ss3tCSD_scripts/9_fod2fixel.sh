#!/bin/bash
# compute fixel mask
# run 1 job: sbatch ../run_container_mrtrix.sh /mrtrix_src/ss3tCSD_scripts/9_fod2fixel.sh
# by Meaghan Perdue
# Feb 2024

cd /mrtrix_out

fod2fixel -mask template/template_mask.mif -fmls_peak_value 0.12 template/wmfod_template.mif template/fixel_mask -nthreads 16 -debug

#check number of fixels in the resulting mask by running mrinfo -size fixel_mask/directions.mif, it should be in the hundreds-of-thousands
#check output mask in mrview  by opening either the template wm_fod.mif or template_mask.mif, then open index.mif in template/fixel_mask using the fixel plot tool
#should show fixels everywhere that's expected to be WM
#If too liberal, adjust from the default -fmls_peak_value by increasing. If areas of WM are missing, try a lower value