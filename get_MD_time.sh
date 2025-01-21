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
        echo "NO OUTCAR or OUTCAR.gz"
        current_time=0
    fi
    for dir in RUN*/
        do
        if [ -d "$dir" ]; then
            cd "$dir"
            if [ -f "OUTCAR.gz" ]; then
                new_time=$(zgrep Iter OUTCAR.gz | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
                new_time=${new_time:-0} # Default to 0 if new_time is unset
                echo "$dir time: $new_time"
                current_time=$((current_time + new_time))
            else
                echo "$dir has no OUTCAR.gz"
                new_time=0
            fi
            cd ../
        fi
    done
    echo "For $i, total RunTime is: $((current_time / 1000)) ps"
    echo " "
    cd ../
done
