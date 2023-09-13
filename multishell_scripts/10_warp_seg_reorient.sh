#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:30:00			      

#warp subjects' FOD images into template space
#segment each FOD lobe (computes AFD per fixel)
#reorient fixels in template space based on local transformation at each voxel
#script by Meaghan Perdue, Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/${1}/${2}

mrtransform wmfod_norm.mif -warp subject2template_warp.mif -reorient_fod no fod_in_template_space_NOT_REORIENTED.mif -nthreads 4 
fod2fixel -mask $mrtrix_ms/template/template_mask_reading_subs.mif fod_in_template_space_NOT_REORIENTED.mif fixel_in_template_space_NOT_REORIENTED -afd fd.mif -nthreads 4 
fixelreorient fixel_in_template_space_NOT_REORIENTED subject2template_warp.mif fixel_in_template_space -nthreads 4 

#After this step, the fixel_in_template_space_NOT_REORIENTED folders can be safely removed.
