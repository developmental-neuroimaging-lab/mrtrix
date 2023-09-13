#move subjects for group average response function

mkdir /work/lebel_lab/mrtrix_multishell/group_average/${1}
mkdir /work/lebel_lab/mrtrix_multishell/group_average/${1}/${2}
cp -R /work/lebel_lab/mrtrix_multishell/${1}/${2}/*.txt /work/lebel_lab/mrtrix_multishell/group_average/${1}/${2}
