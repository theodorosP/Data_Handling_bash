#! /bin/bash

last_run() {
    local base_dir="${1:-.}"
    local last_run
    local new_run

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


last_run
