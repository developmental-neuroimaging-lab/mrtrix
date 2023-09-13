#!/bin/bash
#SBATCH --partition=cpu2021 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:20:00			      # Job should run up to 20 mins

# Concatenate b750 and b2000 data for multishell CSD
# run on preprocessed, upsampled DWI data
# by Meaghan Perdue
# Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4
module load ants/2.3.1
module load fsl/6.0.0-bin

#mrtrix directory (contains preprocessed b750 and b2000 data)
export mrtrix=/home/meaghan.perdue/mrtrix
#multishell output directory
export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

#create a subject folder in the multishell directory, sub-folder for session, and sub-folder for preprocessing outputs
mkdir $mrtrix_ms/${1}
mkdir $mrtrix_ms/${1}/${2}
mkdir $mrtrix_ms/${1}/${2}/tmp

#b750 has 54 slices, b2000 has 42 slices, need to match in order to concatenate, so pad b2000 to match b750
#mrgrid $mrtrix/${1}/${2}/${1}_${2}_dwi_b2000_preprocessed_upsampled.mif pad -as $mrtrix/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_upsampled.mif -fill nan $mrtrix_ms/${1}/${2}/tmp/dwi_b2000_pad.mif 

#for subjects with b2000 55 slices, crop instead (keeping 'pad' in the name for simplicity)
mrgrid $mrtrix/${1}/${2}/${1}_${2}_dwi_b2000_preprocessed_upsampled.mif crop -as $mrtrix/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_upsampled.mif $mrtrix_ms/${1}/${2}/tmp/dwi_b2000_pad.mif -force


#co-register the DWI runs for concatenation (b2000 to b750)
mrregister $mrtrix_ms/${1}/${2}/tmp/dwi_b2000_pad.mif $mrtrix/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_upsampled.mif -type rigid -force

#concatenate converted dwi runs into a single file (topup/eddy handle registration/alignment automatically)
mrcat $mrtrix/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_upsampled.mif $mrtrix_ms/${1}/${2}/tmp/dwi_b2000_pad.mif $mrtrix_ms/${1}/${2}/${1}_${2}_dwi_multishell.mif  

#cleanup temp files
rm -R $mrtrix_ms/${1}/${2}/tmp
