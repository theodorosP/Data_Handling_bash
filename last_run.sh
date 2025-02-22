#!/bin/bash

last_run() {
    local base_dir=$(pwd)
    local last_run
    local new_run

    # Check if OUTCAR.gz is missing
    if [ ! -f "$base_dir/OUTCAR.gz" ]; then
        echo "File OUTCAR.gz is not found. Check the directory: $base_dir"
        return 1
    fi

    # Check if POSCAR, CONTCAR, and REPORT are all missing
    if [ ! -f "$base_dir/POSCAR" ] && [ ! -f "$base_dir/CONTCAR" ] && [ ! -f "$base_dir/REPORT" ]; then
        # Check if at least one RUN directory exists (RUN1, RUN2, etc.)
        if find "$base_dir" -maxdepth 1 -type d -name 'RUN[0-9]*' | grep -q .; then
            echo "Nothing to do in: $base_dir"
            return 0
        fi
    fi

    # Find the last RUN directory
    last_run=$(find "$base_dir" -maxdepth 1 -type d -name 'RUN[0-9]*' | sort -V | tail -n 1)

    if [[ -z "$last_run" ]]; then
        new_run="${base_dir}/RUN1"
    else
        num=$(echo "$last_run" | grep -o '[0-9]*$')
        new_run="${base_dir}/RUN$((num + 1))"
    fi
    mkdir -p "$new_run"

    find "$base_dir" -maxdepth 1 -type f -exec mv {} "$new_run" \;

    echo "Files moved to $new_run"
}


for i in 7
do
    dir="/home/theodoros/PROJ_ElectroCat/theodoros/HER/Au/HER_Au/slow_grow_method/NH4/1_NH4/H2O_splitting_NOT_from_NH4_hydration_shell/1_NH4_40_H2O_v$i"

    if [ -d "$dir" ]; then
        cd "$dir"
		last_run
    else
        echo "Directory not found: $dir"
    fi
done
