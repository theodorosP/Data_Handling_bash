#!/bin/bash

dirs=$(ls -d */ | sort -V)

for i in $dirs
do
    echo " "
    echo "dir = $i"
    if cd "$i"; then
        current_time=0
        if [ -f "OUTCAR" ]; then
            current_time=$(grep -a Iter OUTCAR | tail -1 | awk '{gsub(/\(.*\)/, ""); print $3}')
            echo "current_time = $current_time"
        else
            echo "NO OUTCAR or OUTCAR.gz"
        fi
        for dir in $(ls -d RUN*/ | sort -V)
        do
            if [ -d "$dir" ]; then
                if cd "$dir"; then
                    if [ -f "OUTCAR.gz" ]; then
                        new_time=$(zcat OUTCAR.gz | strings | grep -n Iter | tail -1 | sed 's/.*Iteration *\([0-9]*\).*/\1/')
                        echo "$dir time: $new_time"
                        current_time=$((current_time + new_time))
                    else
                        echo "NO OUTCAR.gz in $dir"
                    fi
                    cd ../
                fi
            fi
        done
        echo "For $i, total RunTime is: $((current_time / 1000)) ps"
        cd ../
    fi
done

for i in {1..20};
do
    echo -n "--"
done
echo " "
