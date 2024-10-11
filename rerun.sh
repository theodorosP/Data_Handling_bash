#!/bin/bash

a=$(ls -d */)
for i in $a
do
    cd $i
    b=$(ls -ltr | grep -c ^d)
    num=$(echo "$b + 1" | bc)
    mkdir "RUN_$num"
    last_folder=$(ls -1t --group-directories-first | grep '^RUN_' | head -n 1)
    find . -maxdepth 1 ! -name "$last_folder" ! -name "." -exec cp -r {} "$last_folder/" \;
    echo "Files Copied to to $last_folder"
    cd ../
done
rm -rf slurm*
sbatch job

