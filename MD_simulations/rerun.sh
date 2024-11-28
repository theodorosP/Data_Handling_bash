#! /bin/bash

source zip_and_copy_files.sh

dirs=$(ls -d */)

for i in $dirs
do
	cd $i
	sub_dirs=$(ls -d */)
	for j in $sub_dirs
	do
		name=$j
		echo $name
		print_dashes "$name"
		cd $j
		zip_and_copy
		cd ../
	done
	cd ../
done
