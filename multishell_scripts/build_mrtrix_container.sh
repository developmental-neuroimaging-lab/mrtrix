#!/bin/bash
#SBATCH --partition=cpu2022 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                                  
#SBATCH --time=01:00:00			     
#SBATCH --mail-user=meaghan.perdue@ucalgary.ca

module load singularity
module load squashfs
export SINGULARITY_CACHEDIR=/home/$USER
export SINGULARITY_TMPDIR=/home/$USER

cd /work/lebel_lab/mrtrix_multishell

singularity build MRtrix3.sif docker://mrtrix3/mrtrix3:3.0.4
