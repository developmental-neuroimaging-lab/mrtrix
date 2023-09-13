#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:30:00			      # Job should run up to 6 hours

# create template mask based on all subjects' masks
# run 1 job (dont need to loop per subject)
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms

mrmath template/warped_mask_input/*_mask_in_template_space.mif min template/template_mask_reading_subs.mif -datatype bit

echo "Check template mask for brain coverage!"
