#!/bin/bash

dirs=$(ls -d */)

for i in $dirs
    do
    echo " "
    echo "dir = $i"
    cd "$i"
    if [ -f "OUTCAR" ]; then
        current_time=$(grep Iter OUTCAR | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
        echo "current_time = $current_time"
    elif [ -f "OUTCAR.gz" ]; then
        current_time=$(zgrep Iter OUTCAR.gz | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
        echo "current_time = $current_time"
    else
        echo "NO OUTCAR  or OUTCAR.gz"
    fi
    for dir in RUN*/
        do
        if [ -d "$dir" ]; then
            cd "$dir"
            #echo "Directory: $i/$dir"
            new_time=$(zgrep Iter OUTCAR.gz | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
            echo "$dir time: $new_time"
            current_time=$((current_time + new_time))
            cd ../
        fi
    done
    echo "For $i, total RunTime is: $((current_time / 1000)) ps"
    echo " "
    cd ../
done
