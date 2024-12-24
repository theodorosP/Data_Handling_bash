#!/bin/bash

path=$(pwd)
dirs=($(find "$path" -maxdepth 1 -type d | sort -V))

for ((i = 0; i < ${#dirs[@]}; i++)); do
    dir1=${dirs[i]}
    if [[ ! -f "$dir1/ICONST" ]]; then
        continue
    fi
    ICONST_CONTENT=$(<"$dir1/ICONST")
    for ((j = i + 1; j < ${#dirs[@]}; j++)); do
        dir2=${dirs[j]}
        if [[ -f "$dir2/ICONST" ]]; then
            OTHER_ICONST_CONTENT=$(<"$dir2/ICONST")
            if [[ "$ICONST_CONTENT" == "$OTHER_ICONST_CONTENT" ]]; then
                echo "Duplicate ICONST found:"
                echo "$dir1/"
                echo "$dir2/"
                echo
            fi
        fi
    done
done
