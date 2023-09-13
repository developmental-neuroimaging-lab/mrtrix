#!/bin/bash
#SBATCH --partition=cpu2021 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=06:00:00			      # Job should run up to 6 hours

# Create group average response function for fixel based analysis
# Response function estimation should be complete for all subjects before running this step
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

#multishell output directory
export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms

responsemean $mrtrix_ms/group_average/*/*/wm_response.txt $mrtrix_ms/group_average_response_wm.txt -force
responsemean $mrtrix_ms/group_average/*/*/gm_response.txt $mrtrix_ms/group_average_response_gm.txt -force
responsemean $mrtrix_ms/group_average/*/*/csf_response.txt $mrtrix_ms/group_average_response_csf.txt -force
