#submit jobs for a batch of subjects on ARC
#subjects should include list of subjects and sessions in the format sub-NNNNN ses-NN

subjects=subs_missed.txt

while read i; do
    sbatch 1_concat_b75.sh ${i}
    done <"$subjects"
