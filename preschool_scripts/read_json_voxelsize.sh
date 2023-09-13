for i in $(cat quad_folders_b750_json.txt); do
    grep -A3 '"data_vox_size"' $i | tee -a voxel_size_b750_json.txt 
    done