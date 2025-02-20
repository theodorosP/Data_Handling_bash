#!/bin/bash

last_run() {
    local base_dir=$(pwd)
    local last_run
    local new_run

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

