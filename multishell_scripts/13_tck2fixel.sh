#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=16               
#SBATCH --time=00:20:00			      

# Convert tracts segmented from tractseg to fixel maps
# convert tract to fixelmaps (tract density map of number of streamlines passing through each fixel)
# threshold fixels with a minimum of 5 streamlines and binarize
# set up text files for stats output
#script by Meaghan Perdue, Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/template
mkdir tractseg_output/fixel_masks

tracts=("AF_left" "AF_right" "SLF_III_left" "SLF_III_right" "ILF_left" "ILF_right" "IFO_left" "IFO_right")

for i in ${tracts[@]}; do
    tck2fixel tractseg_output/TOM_trackings/${i}.tck fixel_mask_reading_subs tractseg_output/fixel_masks/${i} ${i}.mif 
    mrcalc tractseg_output/fixel_masks/${i}/${i}.mif 5 -ge tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif
    echo subj_id    ses_id  ${i}_fd_m 	${i}_fd_sd 	${i}_log_fc_m   ${i}_log_fc_sd  ${i}_fdc_m  ${i}_fdc_sd	>> ${i}_stats.txt
    done

# visual check
#fixel2tsf tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif tractseg_output/TOM_trackings/${i}.tck tractseg_output/fixel_masks/${i}/${i}.tsf