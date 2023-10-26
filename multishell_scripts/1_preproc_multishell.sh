#!/bin/bash
# Convert DWI b750 and b2000 to mif, resample to 2.2 mm voxels
# Concatenate b750 and b2000 data for multishell CSD and run preprocessing
# Directories are relative to container as input to --bind option in run_container_mrtrix.sh
# by Meaghan Perdue
# October 2023

#create a subject folder in the multishell directory, sub-folder for session, and sub-folder for preprocessing outputs
#mkdir -p /mrtrix_ms/data/${1}/${2}/tmp

cd /mrtrix_ms/data/${1}/${2}

#resample to 2.2mm isotropic voxels (matching to original in-plane resolution of the acquisition
#echo "-------- resample raw dwi to 2.2 mm isotropic voxels --------"
#mrgrid /bids_dir/${1}/${2}/dwi_flip/${1}_${2}_acq-b750_dwi.nii.gz regrid -vox 2.2 tmp/dwi_b750_2mm.nii.gz 
#mrgrid /bids_dir/${1}/${2}/dwi_flip/${1}_${2}_acq-b2000_dwi.nii.gz regrid -vox 2.2 tmp/dwi_b2000_2mm.nii.gz 

# create DWI b2000 mask in 2.2mm voxel resolution using bet (mrtrix dwi2mask tool left bad holes)
#echo "-------- Create DWI mask --------"
bet tmp/dwi_b2000_2mm.nii.gz tmp/dwi_b2000_2mm_bet -f .4 -m

#convert DWIs to .mif format 
#mrconvert tmp/dwi_b750_2mm.nii.gz tmp/dwi_b750_2mm.mif -fslgrad /bids_dir/Preschool_b750.bvec /bids_dir/Preschool_b750.bval 
#mrconvert  tmp/dwi_b2000_2mm.nii.gz tmp/dwi_b2000_2mm.mif -fslgrad /bids_dir/Preschool_b2000.bvec /bids_dir/Preschool_b2000.bval 

# crop b750 to match b2000
mrgrid tmp/dwi_b750_2mm.mif crop -as tmp/dwi_b2000_2mm.mif tmp/dwi_b750_crop.mif

# Use dwicat tool to do intensity normalization of runs and concatenate
echo "-------- Intensity normalize and concatenate b750 and b2000 --------"
dwicat tmp/dwi_b750_crop.mif tmp/dwi_b2000_2mm.mif tmp/dwi_multishell.mif -mask tmp/dwi_b2000_2mm_bet_mask.nii.gz

# Gibbs ringing correction
echo "-------- Gibbs ringing correction --------" 
mrdegibbs tmp/dwi_multishell.mif tmp/dwi_multishell_degibbs.mif 

#DWI preprocessing via FSL's eddy correct for eddy current correction and motion correction
#eddy options slm=linear set due to small number of directions (<60), must include space inside quotes for eddy options to work
#eddy options repol set to run outlier replacement - helps with motion correction
#use openmp for faster processing, change nthreads as appropriate
echo "-------- Eddy correction via dwifslpreproc --------"
dwifslpreproc tmp/dwi_multishell_degibbs.mif ${1}_${2}_dwi_multishell_2mm_preprocessed.mif \
	-eddy_options " --slm=linear --repol" \
	-rpe_none -pe_dir AP \
	-eddyqc_all ${1}_${2}_multishell.qc \
	-nthreads 16 \
	-force

dwi2mask ${1}_${2}_dwi_multishell_2mm_preprocessed.mif ${1}_${2}_dwi_multishell_2mm_preprocessed_mask.mif

#cleanup temp files
#rm -R /mrtrix_ms/${1}/${2}/tmp