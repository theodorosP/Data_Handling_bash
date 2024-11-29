#!/bin/bash

print_dashes() {
	local input_string="$1"
	for i in $(seq 0 $((${#input_string} - 1)))
	do
		echo -n "-"
	done
	echo
}

last_part_of_the_path() {
    path=$(pwd)
    last_part=$(basename "$path")
    echo "$last_part"
}

get_part_after_underscore(){
    a=$(ls -d */)
    first_folder_name=${a%%/*}
    part_after_underscore="${first_folder_name#*_}"
    for folder in $a; do
        folder_name=${folder%%/*}
        part="${folder_name#*_}"
        if [[ "$part" != "$part_after_underscore" ]]; then
            echo "Error: Not all directories have the same part after '_'."
            return 1
        fi
    done
    echo "$part_after_underscore"
}

get_paths(){
    if [[ ! -f "$1" ]]; then
        echo "Error: File '$1' not found in the current directory."
        exit 1
    fi
    list=()
    for i in $(seq 1 7)
    do
        path=$(grep -m 1 "dir$i" "$1" | sed 's/^dir[0-9]*="\(.*\)"$/\1/')
        list+=("$path")
    done
    echo "${list[@]}"
}

zip_and_copy(){
a=$(ls -ltr | grep -c ^d)
num=$(echo "$a + 1" | bc)
mkdir "RUN$num"
if [[ -f OUTCAR ]]; then
	echo Zipping OUTCAR
	gzip OUTCAR
else
	echo OUTCAR NOT found
fi
find . -maxdepth 1 -type f -exec cp {} "RUN$num/" \;
rm -rf slurm*
mv CONTCAR POSCAR
NELECT_OUTCAR=$(zgrep "NELECTCURRENT" OUTCAR | tail -1 | awk '{print $2}')
echo "$NELECT_OUTCAR"
NELECT_INCAR=$(grep "NELECT =" INCAR | tail -1 | awk '{print $3}')
echo "$NELECT_INCAR"
sed -i "s/NELECT = $NELECT_INCAR/NELECT = $NELECT_OUTCAR/g" INCAR
echo
}
