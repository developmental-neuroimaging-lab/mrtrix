#!/bin/bash
#SBATCH --partition=cpu2023 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:15:00			      

# dMRI preprocessing for Preschool data with 2 b-vals (b750 & b2000) for CSD in MRtrix
# run on HPC
# by Meaghan Perdue
# August 2023
module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4
 
#set directory names based on directories in HPC

#multishell
export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/${1}/${2}

#run response function estimation
dwi2response dhollander ${1}_${2}_dwi_multishell.mif wm_response.txt gm_response.txt csf_response.txt -voxels voxels.mif  -info

#optionally view outputs, check shapes by tissue type (sphere vs. flattened) at each bval
#shview wm_response.txt
