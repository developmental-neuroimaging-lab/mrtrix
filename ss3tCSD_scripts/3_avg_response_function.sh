#!/bin/bash
# Create group average response function for fixel based analysis
# Response function estimation should be complete for all subjects before running this step
# by Meaghan Perdue
# Oct 2023

mkdir /mrtrix/ss3t_group_average

responsemean /mrtrix/*/*/ss3t_csd/wm_response.txt /mrtrix/ss3t_group_average/group_average_response_wm.txt -force
responsemean /mrtrix/*/*/ss3t_csd/gm_response.txt /mrtrix/ss3t_group_average/group_average_response_gm.txt -force
responsemean /mrtrix/*/*/ss3t_csd/csf_response.txt /mrtrix/ss3t_group_average/group_average_response_csf.txt -force
