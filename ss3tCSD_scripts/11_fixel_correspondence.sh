#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:20:00			      

#match subject fixels to template fixels
#saves output to a single fixel directory for all subjects to accommodate later group FBA
#script by Meaghan Perdue, Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/${1}/${2}

fixelcorrespondence fixel_in_template_space/fd.mif $mrtrix_ms/template/fixel_mask_reading_subs $mrtrix_ms/template/fd ${1}_${2}.mif -nthreads 4 
