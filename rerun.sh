#!/bin/bash

a=$(ls -d */)
for i in $a
do
    cd $i
    b=$(ls -ltr | grep -c ^d)
    num=$(echo "$b + 1" | bc)
    count=1
    for k in OUTCAR REPORT vasprun.xml XDATCAR
    do
        if [ -f "$k" ]; then  # Check if the file exists
            echo "Compressing $i, $count/4 files compressed: $k"
            gzip "$k"
            count=$((count + 1))  # Increment the counter
        fi
    done
    mkdir "RUN$num"
    last_folder=$(ls -1t --group-directories-first | grep '^RUN' | head -n 1)
    find . -maxdepth 1 -type f ! -name "OUTCAR.gz" ! -name "REPORT.gz" ! -name "vasprun.xml.gz" ! -name "XDATCAR.gz" -exec cp {} "$last_folder/" \;
    echo "Files Copied to $last_folder"
    cd ../
done
rm -rf slurm*
sbatch job

