#!/bin/bash
#SBATCH --partition=cpu2023
#SBATCH --ntasks=1				      
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --cpus-per-task=1            
#SBATCH --time=00:30:00			      

#Compute fiber cross-section (FC), logFC, and Fiber density and cross-section (FDC) metrics
#script by Meaghan Perdue, Aug 2023

module load openmpi/4.1.1-gnu
module load mrtrix/3.0.4

export mrtrix_ms=/work/lebel_lab/mrtrix_multishell

cd $mrtrix_ms/template

tracts=("AF_left" "AF_right" "SLF_III_left" "SLF_III_right" "ILF_left" "ILF_right" "IFO_left" "IFO_right")

for i in ${tracts[@]}; do
    echo ${1} ${2} \
    $(mrstats -output mean -output std -mask tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif fd/${1}_${2}.mif) \
    $(mrstats -output mean -output std -mask tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif log_fc/${1}_${2}.mif) \
    $(mrstats -output mean -output std -mask tractseg_output/fixel_masks/${i}/${i}_fixel_mask.mif fdc/${1}_${2}.mif) >> ${i}_stats.txt
    done  





