#symbolic link all FOD images and masks into their input folders

export mrtrix_out=/work/lebel_lab/mrtrix/data

cd $mrtrix_out

ln -sr ${1}/${2}/ss3t_csd/wmfod_norm.mif template/fod_input/${1}_${2}.mif
ln -sr ${1}/${2}/${1}_${2}_dwi_b2000_1mm_bet_mask.nii.gz template/mask_input/${1}_${2}_mask.nii.gz