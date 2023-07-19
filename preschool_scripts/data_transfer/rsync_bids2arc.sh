# transfer data from Rundle to ARC using rsync
# transfers dwi data only (excludes func, anat, perf, and unflipped dwi)
# batchN.txt should contain a list of subjects sub-NNNNN no session numbers, script will copy all sessions
# upate batchN.txt in line 7 to the batch you want to transfer
#update path in line 9 to your user.name
export PS_BIDS=/Volumes/BIDS/CL_Preschool

for i in $(cat batch1.txt); do
    rsync -av $PS_BIDS/${i} --exclude */func --exclude */anat --exclude */perf --exclude */dwi meaghan.perdue@arc.ucalgary.ca:/home/meaghan.perdue/preschool_bids
    done
