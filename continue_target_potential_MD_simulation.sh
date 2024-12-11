#!/bin/bash

cont(){
if [[ -f OUTCAR ]]; then
    a=$(ls -ltr | grep -c ^d)
    num=$(echo "$a + 1" | bc)
    mkdir "RUN$num"
    echo Zipping OUTCAR
    gzip OUTCAR
    find . -maxdepth 1 -type f -exec cp {} "RUN$num/" \;
    rm -rf slurm*
    mv CONTCAR POSCAR
    NELECT_OUTCAR=$(zcat OUTCAR.gz | strings | grep "NELECTCURRENT" | tail -1 | awk '{print $2}')
    echo "$NELECT_OUTCAR"
    NELECT_INCAR=$(grep "NELECT =" INCAR | tail -1 | awk '{print $3}')
    echo "$NELECT_INCAR"
    sed -i "s/NELECT = $NELECT_INCAR/NELECT = $NELECT_OUTCAR/g" INCAR
    rm -rf OUTCAR.gz
else
    echo -e "\e[5mOUTCAR NOT found. Moving to the next folder.\e[0m"
	return 1
fi
}

cd path_to_folder
dirs=$(ls -d */ | sort -V )

for i in $dirs
do
    cd $i
    pwd
    cont
    cd ../
done
