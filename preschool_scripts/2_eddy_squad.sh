# Run eddy squad study-wise QC summary on a set of eddy QUAD outputs
# Run on local machine or adapt for ARC
# This script can be re-run on any specific group of subjects included in an analysis for study-specific reporting:
# to do so, update b750_subs.txt and b2000_subs.txt and output folders accordingly
# Script by Meaghan Perdue June 2023

export MRTRIX_OUT=/Volumes/BIDS/CL_Preschool/derivatives/mrtrix

# Create list of QUAD folders
for i in $(cat b750_subs.txt); do
    echo $MRTRIX_OUT/${i}/ses-*/*_b750.qc/quad | tr " " "\n" >> quad_folders_b750.txt
    done

for i in $(cat b2000_subs.txt); do
    echo $MRTRIX_OUT/${i}/ses-*/*_b2000.qc/quad | tr " " "\n" >> quad_folders_b2000.txt
    done

# Run SQUAD
eddy_squad quad_folders_b750.txt -o $MRTRIX_OUT/QC_SQUAD_b750

eddy_squad quad_folders_b2000.txt -o $MRTRIX_OUT/QC_SQUAD_b2000
