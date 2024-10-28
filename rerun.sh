#!/bin/bash

a=$(ls -d */)
for i in $a
do
    cd "$i"
    echo Folder: $i
    ./rerun.sh
    cd ../
done
[trahman@viper02 MD]$ cd -
/viper/u/trahman/data/theo/HER_Au/MD/CH3NH3
[trahman@viper02 CH3NH3]$ cat rerun.sh 
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
    files=`ls -p | grep -v /`
    mkdir "$last_folder"
    for file in $files; do
        if [[ "$file" != "$last_folder" ]]; then
            cp -rn "$file" "$last_folder"
        fi
    done
    echo "Files Copied to $last_folder"
    mv CONTCAR POSCAR
    rm -rf *.gz
    cd ../
done
rm -rf slurm*
sbatch job
