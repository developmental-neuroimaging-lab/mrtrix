#symbolic link all FOD images and masks into their input folders

ln -sr ${1}/${2}/wmfod_norm.mif template/fod_input/${1}_${2}.mif
ln -sr ${1}/${2}/mask.mif template/mask_input/${1}_${2}_mask.mif
