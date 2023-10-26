#!/bin/bash
#SBATCH --partition=cpu2022 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=04:00:00			      # Job should run up to 4 hours

# Submit job to run via MRTrix3 Container
# Make sure all folder permissions for directories in APPTAINER_BINDPATH are enabled
# Container has MRTrix version 3.0.4, plus all relevant dependencies and required tools from FSL & ANTS

export OMP_NUM_THREADS=16
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=16
##### END OF JOB DEFINITION #####

img_path=/work/lebel_lab/mrtrix_multishell/MRtrix3.sif

export APPTAINER_BINDPATH="/work/lebel_lab/mrtrix_multishell:/mrtrix_ms,/home/meaghan.perdue/preschool_bids:/bids_dir"

# run container
apptainer exec ${img_path} "$@"
    