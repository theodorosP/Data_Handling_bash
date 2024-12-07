k#!/bin/bash

cont(){
a=$(ls -ltr | grep -c ^d)
num=$(echo "$a + 1" | bc)
mkdir "RUN$num"
if [[ -f OUTCAR ]]; then
    echo Zipping OUTCAR
    gzip OUTCAR
else
    echo -e "\e[5mOUTCAR NOT found. Moving to the next folder.\e[0m"
	return 1
fi
find . -maxdepth 1 -type f -exec cp {} "RUN$num/" \;
rm -rf slurm*
mv CONTCAR POSCAR
NELECT_OUTCAR=$(zgrep "NELECTCURRENT" OUTCAR.gz | tail -1 | awk '{print $2}')
echo "$NELECT_OUTCAR"
NELECT_INCAR=$(grep "NELECT =" INCAR | tail -1 | awk '{print $3}')
echo "$NELECT_INCAR"
sed -i "s/NELECT = $NELECT_INCAR/NELECT = $NELECT_OUTCAR/g" INCAR
rm -rf OUTCAR.gz
}


cd /viper/u/trahman/data/theo/HER_Au/slow_grow_method/NH4/5_NH4
dirs=$(ls -d */ | sort -V )

for i in $dirs
do
    cd $i
    pwd
    cont
    cd ../
done

