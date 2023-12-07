#! /bin/bash

look_for_file(){
    local file_name=$1
        if [ -f "$file_name" ]; then
        path=`pwd`
        echo File $file_name is found in path: $path
    fi
}

a=`ls -d */`
file="slurm-7236805.out"
for i in $a
do
    cd $i
    look_for_file $file
    cd ../
done


