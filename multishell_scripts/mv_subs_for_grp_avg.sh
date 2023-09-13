#move subjects to folder for calculating group average response function


subjects=subs_for_group_avg.txt

while read i; do
    sh move.sh ${i}
    done <"$subjects"