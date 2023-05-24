# Summary of processing steps for Preschool DWI data via mrtrix3

## Preprocessing
Run separately for b750 and b2000 data
1. Convert nifti data to .mif
2. Resample data to 2.2 mm isotropic voxels
3. Gibbs Ringing removal
4. eddy current and motion correction via FSL eddy
5. QC via FSL eddy_quad
6. brain mask creation
7. convert preprocessed output and mask to nifti
