#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=06:00:00			      # Job should run up to 6 hours

# create template mask based on all subjects' masks
# run 1 job (dont need to loop per subject)
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms

fod2fixel -mask template/template_mask_reading_subs.mif -fmls_peak_value 0.06 template/wmfod_template.mif template/fixel_mask_reading_subs -nthreads 16 -debug

#check number of fixels in the resulting mask by running mrinfo -size fixel_mask/directions.mif, it should be in the hundreds-of-thousands
#check output mask in mrview  by opening either the template wm_fod.mif or template_mask.mif, then open index.mif in template/fixel_mask using the fixel plot tool
#should show fixels everywhere that's expected to be WM
#on a214 data, it was far to liberal (>2 million), so adjusted from the default -fmls_peak_value by increasing to .22. If areas of WM were missing, try a lower value