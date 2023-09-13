#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:30:00			      # Job should run up to 6 hours

# Register subject's FODs to FOD template and warp masks to template space
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4
module load ants/2.3.1

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/${1}/${2}
mrregister wmfod_norm.mif -mask1 mask.mif $mrtrix_ms/template/wmfod_template.mif -nl_warp subject2template_warp.mif template2subject_warp.mif -nthreads 4 
mrtransform mask.mif -warp subject2template_warp.mif -interp nearest -datatype bit dwi_mask_in_template_space.mif -nthreads 4 

