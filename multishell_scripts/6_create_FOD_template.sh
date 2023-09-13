#!/bin/bash
#SBATCH --partition=cpu2021 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=24:00:00			      # Job should run up to 6 hours

# create study-specific FOD template
# this takes a long time, ensure that time limit is set to ~24 hours, if the job fails, rerun sbatch with -continue
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms

population_template template/fod_input -mask_dir template/mask_input template/wmfod_template.mif -voxel_size 1.25 -debug -nthreads 32

# calculate FOD peaks for tractseg on template
sh2peaks template/wmfod_template.mif  template/wmfod_template_peaks.nii.gz -nthreads 16
