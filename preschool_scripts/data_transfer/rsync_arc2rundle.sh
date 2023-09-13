#!/bin/bash
# transfer processed data from ARC to Rundle using rsync
# batchN.txt should contain a list of subjects sub-NNNNN no session numbers, script will copy all sessions
# upate batchN.txt in line 7 to the batch you want to transfer
#update path in line 9 to your user.name
export PS_MRTRIX=/Volumes/catherine_team/MRI_Data/2_BIDS_Datasets/preschool/derivatives/mrtrix

for i in $(cat batch1.txt); do
    rsync -av --exclude */preproc meaghan.perdue@arc.ucalgary.ca:/home/meaghan.perdue/mrtrix/${i} $PS_MRTRIX
    done
