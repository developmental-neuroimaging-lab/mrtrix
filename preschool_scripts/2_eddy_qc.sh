#!/bin/bash
#SBATCH --partition=cpu2022 
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:30:00			      # Job should run up to 4 hours

#Meaghan Perdue Feb 2024
# eddy qc data prep and script for preprocessed data
# use for failed eddy qc when running mrtrix preproc via container
# Converts/renames mrtrix fslpreproc output files to format readable by eddy_quad
# runs eddy_quad single subject level QC
# quad output to new sub-folder in sub-XX_ses-XX_b2000.qc/sub-XX_ses-XX.qc

export mrtrix_out=/work/lebel_lab/mrtrix/data
export acqparam=/work/lebel_lab/mrtrix/src/acqparams.txt
export index=/work/lebel_lab/mrtrix/src/index.txt

module load mrtrix/3.0.4
module load fsl/6.0.0

cd $mrtrix_out/${1}/${2}

#b750 data
# mrconvert ${1}_${2}_dwi_b750_preprocessed_1mm.mif ${1}_${2}_b750.qc/${1}_${2}.nii.gz -export_grad_fsl ${1}_${2}_b750.qc/${1}_${2}.bvec ${1}_${2}_b750.qc/${1}_${2}.bval
cd ${1}_${2}_b750.qc
# mv eddy_mask.nii ${1}_${2}.eddy_mask.nii
# mv eddy_movement_rms ${1}_${2}.eddy_movement_rms
# mv eddy_outlier_map ${1}_${2}.eddy_outlier_map
# mv eddy_outlier_n_sqr_stdev_map ${1}_${2}.eddy_outlier_n_sqr_stdev_map
# mv eddy_outlier_n_stdev_map ${1}_${2}.eddy_outlier_n_stdev_map
# mv eddy_outlier_report ${1}_${2}.eddy_outlier_report
# mv eddy_parameters ${1}_${2}.eddy_parameters
# mv eddy_post_eddy_shell_PE_translation_parameters ${1}_${2}.eddy_post_eddy_shell_PE_translation_parameters
# mv eddy_post_eddy_shell_alignment_parameters ${1}_${2}.eddy_post_eddy_shell_alignment_parameters
# mv eddy_restricted_movement_rms ${1}_${2}.eddy_restricted_movement_rms
# eddy_quad ${1}_${2} -idx $index -par $acqparam -m ../${1}_${2}_dwi_b750_1mm_bet_mask.nii.gz -b ${1}_${2}.bval
mv ${1}_${2}.qc quad
	
cd $mrtrix_out/${1}/${2}

#b2000 data
# mrconvert ${1}_${2}_dwi_b2000_preprocessed_1mm.mif ${1}_${2}_b2000.qc/${1}_${2}.nii.gz -export_grad_fsl ${1}_${2}_b2000.qc/${1}_${2}.bvec ${1}_${2}_b2000.qc/${1}_${2}.bval
cd ${1}_${2}_b2000.qc
# mv eddy_mask.nii ${1}_${2}.eddy_mask.nii
# mv eddy_movement_rms ${1}_${2}.eddy_movement_rms
# mv eddy_outlier_map ${1}_${2}.eddy_outlier_map
# mv eddy_outlier_n_sqr_stdev_map ${1}_${2}.eddy_outlier_n_sqr_stdev_map
# mv eddy_outlier_n_stdev_map ${1}_${2}.eddy_outlier_n_stdev_map
# mv eddy_outlier_report ${1}_${2}.eddy_outlier_report
# mv eddy_parameters ${1}_${2}.eddy_parameters
# mv eddy_post_eddy_shell_PE_translation_parameters ${1}_${2}.eddy_post_eddy_shell_PE_translation_parameters
# mv eddy_post_eddy_shell_alignment_parameters ${1}_${2}.eddy_post_eddy_shell_alignment_parameters
# mv eddy_restricted_movement_rms ${1}_${2}.eddy_restricted_movement_rms
# eddy_quad ${1}_${2} -idx $index -par $acqparam -m ../${1}_${2}_dwi_b2000_1mm_bet_mask.nii.gz -b ${1}_${2}.bval
mv ${1}_${2}.qc quad
	