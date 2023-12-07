#! /bin/bash

for i in  2 3
do
cd path_to_job
num=`ls -ltr|grep -c ^d`
num=$(($num+1))
mkdir $num
cp * $num
rm -rf slurm*
mv CONTCAR POSCAR
sbatch job
done
