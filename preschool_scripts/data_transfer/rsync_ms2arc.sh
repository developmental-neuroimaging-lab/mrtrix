#!/bin/bash
# transfer data from Rundle to ARC using rsync
# transfers dwi data only (excludes func, anat, perf, and unflipped dwi)
# batchN.txt should contain a list of subjects sub-NNNNN no session numbers, script will copy all sessions
# upate batchN.txt in line 7 to the batch you want to transfer
#update path in line 9 to your user.name
export PS_MRTRIX=/Volumes/BIDS/CL_Preschool/derivatives/mrtrix
export ARC_MRTRIX=meaghan.perdue@arc.ucalgary.ca:/home/meaghan.perdue/mrtrix

rsync -av --relative $PS_MRTRIX/./${1}/${2}/*upsampled.mif $ARC_MRTRIX

