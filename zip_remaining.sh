#! /bin/bash

zip_all(){
    local path="$1"
    if [ -d "$path" ]; then
        echo "Folder $path found"
        cd $path
        count=1
        for k in OUTCAR REPORT vasprun.xml XDATCAR
        do
            if [ -f "$k" ]; then
                echo "Compressing $i$k, $count/4 files"
                gzip "$k"
                count=$((count + 1))
            fi
        done
    else
        echo "Error: $path does not exist"
    fi

}


combine(){
    path="$(pwd)"
    for i in Na NH4 CH3NH3
    do
        echo $path_new
        for j in 1_"$i"_40_H2O  3_"$i"_40_H2O  5_"$i"_40_H2O
        do
            new_path=$path"/"$i"/"$j
            echo $new_path
            zip_all $new_path
        done
    done
}

combine 
