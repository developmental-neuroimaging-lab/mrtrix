#!/bin/bash 
# script to view brainmask overlaid on DWI image in mrview for QC
# masks generated during preprocessing using FSL BET
# make sure no holes in mask or large brain areas cut off
# ok if edges are a little eroded as long as substantial white matter not cut off
# b2000 images may have top and bottom slices cut off due to smaller number of slices
# to run this script from the terminal: sh qc_masks.sh sub-10001 ses-01

# view b750
cd /Volumes/BIDS/CL_Preschool/derivatives/mrtrix/${1}/${2}
mrconvert *b750_preprocessed_1mm.mif tmp.nii
fsleyes tmp.nii \
    *b750_1mm_bet_mask.nii.gz -ot mask \
    *b750_tensor_dec_1mm.nii.gz -ot rgbvector
rm tmp.nii


# view b2000
#cd ~/Mirror/mrtrix_ss3tCSD/data/${1}/${2}
#mrview *b2000_preprocessed_1mm.mif -overlay.load *b2000_1mm_bet_mask.nii.gz -mode 2
