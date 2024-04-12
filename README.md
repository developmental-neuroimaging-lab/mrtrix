# mrtrix
## Code for mrtrix processing of DWI data
Developed by Meaghan Perdue, spring 2023

These scripts are written for processing data in batches using the ARC High Performance Computing Cluster.

### ARC access and set-up
1. To get access to the ARC, follow instructions here: https://rcs.ucalgary.ca/ARC_Cluster_Guide 

2. Ask Bryce for access to the /work/lebel_lab share 

3. Set up ssh key so you can securely log in and transfer data without entering your password every time: <https://www.ibm.com/support/pages/configuring-ssh-login-without-password>

### Things to note before you begin
Scripts are written in bash and may not be fully compatible with z-shell. Change default shell to bash by running: 
```
chsh -s /bin/bash
```
Scripts beginning with #!/bin/bash should use bash as the command interpreter automatically.

Processing scripts are organized by study and expect as input a BIDS-compliant DWI dataset
Scripts are numbered in the order in which they should be performed.

### How to copy data to the ARC
1. Set up your ARC home directory. Log into ARC, then create a bids directory (if processing raw data):
    ```
    mkdir preschool_bids
    ```
2. Copy data from Rundle to ARC using rsync (run from a terminal NOT logged into ARC): \
For 1 subject:
    ``` 
    rsync -av /Volumes/BIDS/CL_Preschool/sub-XXXXX --exclude */func --exclude */anat --exclude */perf user.name@arc.ucalgary.ca:/work/lebel_lab/ps_bids_dwi 
    ```
    The above will copy dwi folders for all sessions from the given subject to the preschool_bids folder on ARC, excluding other data modalities. \
For a batch of subjects: \
List subject IDs in a text file named tmp.txt \
Run ` preschool_scripts/data_transfer/rsync_bids2arc.sh ` on the batch file from your local terminal. \
Script will copy all sessions for that subject to ARC. 

**IMPORTANT NOTE:** *Do not use the .bvec/.bval files from the subject's bids directories, use the b750_grad_mrtrix.txt and b2000_grad_mrtrix.txt gradient files instead, following import included in the preprocessing scripts to ensure correct directions*

### How to use these scripts 
*Scripts are located on the ARC under /work/lebel_lab/mrtrix/src and set to run in MRtrix3 container and output to /work/lebel_lab/mrtrix/data*
1. Log into ARC and navigate to /work/lebel_lab/mrtrix/src
2. Create a subject list text file (e.g., b750_subs.txt) with one subject and session per line in the format: \
        sub-10001 ses-01 \
        sub-10001 ses-02 \
        sub-10002 ses-01 \
        sub-10002 ses-02 \
3. Copy the subject list to the ARC directory /work/lebel_lab/mrtrix/src using rsync or scp. \

4. Edit submit_jobs_container.sh so that 'subjects' matches file name of your subject lists and sbatch is set to run the script(s) you wish to run. If you are only running a process on b750 data, comment out the lines for b2000 data. \
        ``` 
        nano submit_jobs_container.sh 
        ``` \
        CTRL+X to exit, Y to save \
     Run submit_jobs_container.sh (from terminal logged in to ARC): \
        ``` 
        sh submit_jobs_container.sh 
        ``` \
        This will submit a separate job for each subject/session in your subject list \
Output files will be saved to the /work/lebel_lab/mrtrix/data directory on ARC.
        ``` \
        **Note: you may add paths to the APPTAINER_BINDPATH in the run_container_mrtrix.sh script by adding them between the quotes with comma separation. These tell the container where source data is and where output data should go relative to the ARC space. The format is /ARC/ABSOLUTE/PATH:/DESIRED/CONTAINER/PATHNAME. Please do not remove existing paths that may be in use by others.**


### Notes on the processing pipeline
    The main processing scripts include preprocessing (both b750 and b2000) and tensor fitting (b2000). \
    Optional scripts to run whole brain tractography and compute connectome matrices are included: \
    4_tckgen_wholebrain.sh \
    5_tck2connectome.sh \
    5a_labelconvert.sh - this was run locally to convert the MACRUISE atlas to mrtrix-friendly format \   
    Scripts for fixel-based analysis processing (b2000 da ta only) are located here: /Volumes/catherine_team/Project_Folders/mrtrix/ss3tCSD_scripts \
    These scripts are used to run the single-shell-3Tissue Constrained Spherical Deconvolution and calculate Fixel-based metrics (Fiber Density & Fiber Cross-Section). \
    SS3T-CSD outputs are saved to /work/lebel_lab/mrtrix/data/sub-#####/ses-##/ss3tCSD \
    The CSD step is completed in a separate MRTrix container using the mrtrix3Tissue fork, all other steps completed in the main mrtrix container \

### Check job status and troubleshoot
For each job submitted, a file called slurm-########.out will be printed to your ARC working directory. These files will include text logs of the processing steps. You can read them using: \
        ` cat slurm-#########.out `

To check the status of jobs you've submitted, run: \
        ` squeue --user user.name ` \
    You should see a list of jobs that are running (status "R") and a list of jobs in queue (status "PD")

### Moving data to the server
When your jobs are completed, move the outputs to the Rundle server by running rsync from your local computer. These files are large; ONLY move the output files that you need to visually inspect or work with on your local computer:
```
rsync -av user.name@arc.ucalgary.ca:/work/lebel_lab/mrtrix/* /Volumes/BIDS/CL_Preschool/derivatives/mrtrix 
```