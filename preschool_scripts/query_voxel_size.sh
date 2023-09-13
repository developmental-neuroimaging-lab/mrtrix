# Extract and write voxel size for each subject's preprocessed image to a text file
# MP using to check voxel size differences causing issue for EDDY SQUAD

export MRTRIX_OUT=/Volumes/catherine_team/MRI_Data/2_BIDS_Datasets/preschool/derivatives/mrtrix

for i in $(cat sub_ses_b750.txt); do
    mrinfo $MRTRIX_OUT/${i}/*dwi_b750_preprocessed.nii.gz -spacing | tee -a voxel_size_b750.txt
    done 