#! /bin/bash

gzip_if_exists(){
	dirs=`ls -d */`
	for i in $dirs
	do
		cd $i
		count=1
		for j in OUTCAR REPORT vasprun.xml XDATCAR
		do
			if [[ -f "$j" ]]; then
				path=`pwd`
				last_component=${path##*/}
				echo zipping file: $last_component/$j, $count/4 files
				gzip $j
				count=$((count + 1))
			else
				last_component=${path##*/}
				echo $last_component
				echo File $j not found
				count=$((count + 1))
			fi
		done
		cd ../
	done
}

gzip_if_exists
