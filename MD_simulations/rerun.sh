#!/bin/bash

source process_data.sh

job=job_you_need_to_run

path=$(pwd)
last_part=$(last_part_of_the_path)
type_of_cation=$(get_part_after_underscore)

if [[ "$last_part" != "Na" && "$last_part" != "NH4" && "$last_part" != "CH3NH3" ]]; then
    echo "Test folder"
    sed -i "s|/$type_of_cation/|/$last_part/|g" "$job"
fi

l=($(get_paths "$job"))

echo "Directories extracted from $job:"

for i in "${l[@]}"
do
    cd "$i"
    pwd
    zip_and_copy
done

cd "$path"
#sbatch "$job"
