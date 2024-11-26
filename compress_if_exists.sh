#! /bin/bash

print_dashes() {
    local input_string="$1"  # Take the first argument as the input string
    for i in $(seq 0 $((${#input_string} - 1)))
    do
        echo -n "-"
    done
    echo
}

gzip_if_exists() {
    dirs=$(ls -d */)
    for i in $dirs
    do
        cd "$i"
        count=1
        for j in OUTCAR REPORT vasprun.xml XDATCAR
        do
            if [[ -f "$j" ]]; then
                path=$(pwd)
                last_component=${path##*/}
                message="Zipping file: $last_component/$j, $count/4 files"
                echo "$message"
                gzip "$j"
                count=$((count + 1))
            else
                path=$(pwd)
                last_component=${path##*/}
                message="File: $last_component/$j NOT found"
                echo "$message"
                count=$((count + 1))
            fi
        done
        print_dashes "$message"
        cd ../
    done
}

gzip_if_exists
