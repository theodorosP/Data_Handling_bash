#!/bin/bash

a=$(ls -d */)
for i in $a
do
    cd "$i"
    b=$(ls -ltr | grep -c ^d)
    num=$(echo "$b + 1" | bc)
    count=1
    for k in OUTCAR REPORT vasprun.xml XDATCAR
    do
        if [ -f "$k" ]; then
            echo "Compressing $i$k, $count/4 files"
            gzip "$k"
            count=$((count + 1))
        fi
    done
    last_folder="RUN$num"
    mkdir "$last_folder"
    for file in *; do
        if [[ "$file" != "$last_folder" ]]; then
            cp -rn "$file" "$last_folder"
        fi
    done
    echo "Files Copied to $last_folder"
    rm -rf *.gz
    cd ../
done
rm -rf slurm*
sbatch job
