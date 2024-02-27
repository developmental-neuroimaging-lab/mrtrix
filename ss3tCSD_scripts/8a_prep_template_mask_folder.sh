#!/bin/bash
#create template folder and link FOD images and masks into sub-folders in the template folder


subjects=b2000_subs.txt

while read i; do
    sh link2.sh ${i}
    done <"$subjects"