#!/bin/bash
#SBATCH --partition=cpu2022 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=04:00:00			      # Job should run up to 4 hours

# Submit job to run via MRTrix3Tissue Container
# Use only for running FOD estimation with single-shell 3-tissue method
# for other mrtrix processing, use MRtrix3.sif, which has latest version of MRtrix3 (v3.0.4)
# Make sure all folder permissions for directories in APPTAINER_BINDPATH are enabled

export OMP_NUM_THREADS=16
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=16
##### END OF JOB DEFINITION #####

img_path=/work/lebel_lab/mrtrix/src/ss3tmrtrix.sif

export APPTAINER_BINDPATH="/work/lebel_lab/mrtrix:/mrtrix"

# run container
apptainer exec ${img_path} "$@"