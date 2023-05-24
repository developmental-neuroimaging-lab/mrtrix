#submit jobs for a batch of subjects on ARC
#subjects_b750 and b2000 should include list of subjects and sessions in the format sub-NNNNN ses-NN

subjects_b750=sublist_b750.txt
subjects_b2000=sublist_b2000.txt

while read i; do
    sbatch 1_preproc_b750_arc.sh ${i}
    done <"$subjects_b750"
while read j; do
    sbatch 1_preproc_b2000_arc.sh ${j}
    done <"$subjects_b2000"
    