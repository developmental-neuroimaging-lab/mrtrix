# dMRI preprocessing for Preschool b2000 for CSD in MRtrix
# run on HPC using mrtrix container
# by Meaghan Perdue
# updated 08 Nov 2023

#create a subject folder in the mrtrix directory, sub-folder for session, and sub-folder for preprocessing outputs
mkdir -p /mrtrix_out/${1}/${2}/preproc
mkdir -p /mrtrix_out/${1}/${2}/tmp

echo "-------- Converting .nii.gz to .mif format --------"
#convert DWI to .mif format, first convert .nii.gz to .mif, THEN import grad file, otherwise mrconvert will flip the grad file wrong
#MUST use mrtrix grad file that MP flipped using flip_grad.m script (based on tensor_CL file); do not use .bvec/.bval FSL format
#once in .mif format, the bvecs and bvals will be stored in the image header, if exporting to .nii.gz at any stage, use export-grad-fsl option with mrconvert
mrconvert /bids_dir/${1}/${2}/dwi/${1}_${2}_acq-b2000_dwi.nii.gz /mrtrix_out/${1}/${2}/tmp/tmp_b2000.mif
mrconvert /mrtrix_out/${1}/${2}/tmp/tmp_b2000.mif /mrtrix_out/${1}/${2}/preproc/dwi_b2000.mif -grad /bids_dir/b2000_grad_mrtrix.txt

echo "-------- Resampling to isotropic voxels --------"
resample to 2.2mm isotropic voxels (matching to original slice thickness of the acquisition)
mrgrid /mrtrix_out/${1}/${2}/preproc/dwi_b2000.mif regrid -vox 2.2 /mrtrix_out/${1}/${2}/preproc/dwi_b2000_resampled.mif -info -force

echo "-------- Running Gibbs Ringing Correction --------"
#perform Gibbs Ringing correction 
mrdegibbs /mrtrix_out/${1}/${2}/preproc/dwi_b2000_resampled.mif /mrtrix_out/${1}/${2}/preproc/dwi_b2000_degibbs.mif -info -force

echo "-------- Running eddy correction and motion correction --------"
#DWI preprocessing via FSL's eddy correct for eddy current correction and motion correction
#eddy options slm=linear set due to small number of directions (<60), must include space inside quotes for eddy options to work
#eddy options repol set to run outlier replacement - helps with motion correction
#use openmp for faster processing, change nthreads as appropriate
dwifslpreproc /mrtrix_out/${1}/${2}/preproc/dwi_b2000_degibbs.mif /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b2000_preprocessed.mif \
	-eddy_options " --slm=linear --repol" \
	-rpe_none -pe_dir AP \
	-eddyqc_all /mrtrix_out/${1}/${2}/${1}_${2}_b2000.qc \
	-nthreads 16 \
	-force

# DO NOT run bias correction - resulted in overestimated masks

# echo "-------- Resample to 1mm voxels and create brainmask --------"
upsample to 1 mm isotropic voxels (for improved tractography & registration to T1 etc.)
mrgrid /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b2000_preprocessed.mif regrid -vox 1 /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b2000_preprocessed_1mm.mif -info -force

# Create mask of upsampled DWI using FSL BET - use this if dwi2mask outputs have holes
echo "-------- Creating brainmask --------" 
mrconvert /mrtrix_out/${1}/${2}/${1}_${2}_dwi_b2000_preprocessed_1mm.mif -coord 3 0 -axes 0,1,2 /mrtrix_out/${1}/${2}/tmp/dwi_b2000_1mm_b0.nii.gz
bet /mrtrix_out/${1}/${2}/tmp/dwi_b2000_1mm_b0.nii.gz /mrtrix_out/${1}/${2}/dwi_b2000_1mm_bet -f .4 -m

#cleanup
rm /mrtrix_out/${1}/${2}/dwi_b2000_1mm_bet.nii.gz
rm -R /mrtrix_out/${1}/${2}/tmp

echo ${1} ${2} b2000 >> /mrtrix_out/dwi_preprocessed.txt
