grade=load('/Volumes/catherine_team/Project_Folders/mrtrix/preschool_scripts/tensor_CL.txt');
grade(:,1:3)=grade(:,1:3)*-1;
dlmwrite('/Volumes/catherine_team/Project_Folders/mrtrix/preschool_scripts/temp2_grad_flip.txt',grade,'delimiter' ,' ' ,'precision',16)
%view and manually clean up in text editor, renamed to
%b2000_grad_mrtrix.txt