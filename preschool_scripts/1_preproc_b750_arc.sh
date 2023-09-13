#!/bin/bash
#SBATCH --partition=cpu2021 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=04:00:00			      # Job should run up to 4 hours

# dMRI preprocessing for Preschool b750 for CSD in MRtrix
# data must first be flipped L-R using fslswapdim before copying to ARC. 
# If a newer version of fsl (>6.0.0) becomes available on ARC, the flip can be incorporated as the 1st step in this script.
# run on HPC
# by Meaghan Perdue
# 20 April 2023
module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4
module load ants/2.3.1
module load fsl/6.0.0-bin
 

#set directory names based on directories in HPC
#bids directory
export bids_dir=/home/meaghan.perdue/preschool_bids
#output directory
export mrtrix_out=/work/lebel_lab/mrtrix

#create a subject folder in the mrtrix directory, sub-folder for session, and sub-folder for preprocessing outputs
mkdir $mrtrix_out/${1}
mkdir $mrtrix_out/${1}/${2}
mkdir $mrtrix_out/${1}/${2}/preproc

#convert DWI to .mif format 
mrconvert $bids_dir/${1}/${2}/dwi_flip/${1}_${2}_acq-b750_dwi.nii.gz $mrtrix_out/${1}/${2}/preproc/dwi_b750.mif -fslgrad $bids_dir/Preschool_b750.bvec $bids_dir/Preschool_b750.bval  -force

#resample to 2.2mm isotropic voxels (matching to original in-plane resolution of the acquisition)
mrgrid $mrtrix_out/${1}/${2}/preproc/dwi_b750.mif regrid -vox 2.2 $mrtrix_out/${1}/${2}/preproc/dwi_b750_resampled.mif -info -force

#perform Gibbs Ringing correction 
mrdegibbs $mrtrix_out/${1}/${2}/preproc/dwi_b750_resampled.mif $mrtrix_out/${1}/${2}/preproc/dwi_degibbs.mif -info -force

#DWI preprocessing via FSL's eddy correct for eddy current correction and motion correction
#eddy options slm=linear set due to small number of directions (<60), must include space inside quotes for eddy options to work
#eddy options repol set to run outlier replacement - helps with motion correction
#use openmp for faster processing, change nthreads as appropriate
dwifslpreproc $mrtrix_out/${1}/${2}/preproc/dwi_degibbs.mif $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.mif \
	-eddy_options " --slm=linear --repol" \
	-rpe_none -pe_dir AP \
	-eddyqc_all $mrtrix_out/${1}/${2}/${1}_${2}_b750.qc \
	-nthreads 16 \
	-force

# DO NOT run bias correction - resulted in overestimated masks

#Create a brain mask based on preprocessed DWI for use in speeding up subsequent analysis
# preprocessed DWI and mask saved to subject's derivatives/mrtrix folder
dwi2mask $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.mif $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask.mif -force


#Convert preprocessed output and mask to .nii 
mrconvert $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.mif $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.nii.gz -export_grad_fsl $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.bvec $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.bval -json_export $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.json -force
mrconvert $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask.mif $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask.nii.gz -force

#upsample to 1.25mm isotropic voxels (for improved tractography)
mrgrid $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed.mif regrid -vox 1.25 $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_preprocessed_upsampled.mif -info -force
mrgrid $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask.mif regrid -vox 1.25 $mrtrix_out/${1}/${2}/${1}_${2}_dwi_b750_mask_upsampled.mif -force

echo ${1} ${2} b750 >> $mrtrix_out/dwi_preprocessed.txt
