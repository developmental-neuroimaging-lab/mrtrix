# mrtrix
## Code for mrtrix processing of DWI data
Developed by Meaghan Perdue, spring 2023

These scripts are written for processing data in batches using the ARC High Performance Computing Cluster.
To get access to the ARC, follow instructions here: https://rcs.ucalgary.ca/ARC_Cluster_Guide

Ask Bryce for access to the /work/lebel_lab share 

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
    rsync -av /Volumes/BIDS/CL_Preschool/sub-XXXXX --exclude */func --exclude */anat --exclude */perf user.name@arc.ucalgary.ca:/home/user.name/preschool_bids 
    ```
    The above will copy dwi folders for all sessions from the given subject to the preschool_bids folder on ARC, excluding other data modalities. \
For a batch of subjects: \
List subject IDs in a text file named batchN.txt (where N is the batch number) \
Run ` preschool_scripts/data_transfer/rsync_bids2arc.sh ` on the batch file from your local terminal. \
Script will copy all sessions for that subject to ARC. 

Be sure to copy the .bval and .bvec files from the BIDS parent directory on Rundle to your working BIDS directory on the arc:
    ```
    rsync /Volumes/BIDS/CL_Preschool/*.bvec user.name@arc.ucalgary.ca:/home/user.name/preschool_bids
    rsync /Volumes/BIDS/CL_Preschool/*.bval user.name@arc.ucalgary.ca:/home/user.name/preschool_bids
    ```

### How to use these scripts 
1. Copy the script(s) you want to use to your local working directory.
2. Edit the directory paths to match the directories in your ARC home directory (change to your username and create sub-folders to match bids_dir and/or mrtrix_out)
3. Copy the script(s) to your ARC home directory: \
            ` scp script.sh user.name@arc.ucalgary.ca:/home/user.name `
4. To run a single subject from your ARC home directory do: \
           ` sbatch script.sh sub-XXXXX ses-XX ` \
      (if you are processing data from a study that is not longitudinal, omit 'ses-XX')
5. To run a batch of subjects: \
    a) create a subject list text file (e.g., sublist_b750.txt) with one subject and session per line in the format: \
        sub-10001 ses-01 \
        sub-10001 ses-02 \
        sub-10002 ses-01 \
        sub-10002 ses-02 \
    b) Copy the subject list to your ARC home directory. \
    c) Copy batch_submit_jobs.sh to your ARC home directory. \
    d) Edit batch_submit_jobs.sh so that subjects_b750 and/or subjects_b2000 match file names of your subject lists and sbatch is set to run the script(s) you wish to run. If you are only running a process on b750 data, comment out the lines for b2000 data. \
        ``` 
        nano batch_submit_jobs.sh 
        ``` \
        CTRL+X to exit, Y to save \
    e) Run batch_submit_jobs.sh: \
        ``` 
        sh batch_submit_jobs.sh 
        ``` \
        This will submit a separate job for each subject/session in your sublist(s) \
Output files will be saved to the /work/lebel_lab/mrtrix directory on ARC.

### Check job status and troubleshoot
For each job submitted, a file called slurm-########.out will be printed to your ARC working directory. These files will include text logs of the processing steps. You can read them using: \
        ` cat slurm-#########.out `

To check the status of jobs you've submitted, run: \
        ` squeue --user user.name ` \
    You should see a list of jobs that are running (status "R") and a list of jobs in queue (status "PD")

### Moving data to the server
When your jobs are completed, move the outputs to the Rundle server by running rsync from your local computer:
```
rsync -av user.name@arc.ucalgary.ca:/work/lebel_lab/mrtrix/* /Volumes/BIDS/CL_Preschool/derivatives/mrtrix 
```