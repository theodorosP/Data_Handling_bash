#!/bin/bash

upload_to_github(){

local path="$1"
cd $path
ls $path
files=$(ls -p | grep -v /)
for i in $files
do
    git add "$i"
    git commit -m "commit"
    git push -u origin main
done
}

upload_to_github "/home/thodoris/Downloads/ML_CO2RR_on_Bi/database_HER"
