#!/bin/bash

dirs=$(ls -d */)

for i in $dirs
do
    echo " "
    echo "dir = $i"
    cd "$i"
    current_time=0
    if [ -f "OUTCAR" ]; then
        current_time=$(grep -a Iter OUTCAR | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
        echo "current_time = $current_time"
    elif [ -f "OUTCAR.gz" ]; then
        if file OUTCAR.gz | grep -q "gzip compressed data"; then
            current_time=$(zcat OUTCAR.gz | strings | grep -n Iter | tail -1 | sed 's/.*Iteration *\([0-9]*\).*/\1/')
            echo "current_time (binary) = $current_time"
        else
            current_time=$(zgrep Iter OUTCAR.gz | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
            echo "current_time (text) = $current_time"
        fi
    else
        echo "NO OUTCAR or OUTCAR.gz"
    fi

    for dir in RUN*/
    do
        if [ -d "$dir" ]; then
            cd "$dir"
            if file OUTCAR.gz | grep -q "gzip compressed data"; then
                # If OUTCAR.gz is binary, use zcat, strings
                new_time=$(zcat OUTCAR.gz | strings | grep -n Iter | tail -1 | sed 's/.*Iteration *\([0-9]*\).*/\1/')
                echo "$dir time (binary): $new_time"
            else
                # If OUTCAR.gz is not binary
                new_time=$(zgrep Iter OUTCAR.gz | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
                echo "$dir time (text): $new_time"
            fi
            current_time=$((current_time + new_time))  # Add the time from this RUN subdirectory
            cd ../
        fi
    done

    echo "For $i, total RunTime is: $((current_time / 1000)) ps"
    echo " "

    cd ../
done
