#! /bin/bash

check_if_done(){
	if [ -e OUTCAR ]; then
		find=`grep "General timing and accounting informations for this job:" OUTCAR`
    	if [ -z "$find" ]
    	then
        	echo job NOT COMPLETE, folder: chg_$1/target_potential/$2
    	else
        	echo job is COMPLETE, folder: chg_$1/target_potential/$2
    	fi
	else
		echo "OUTCAR does not exist."  folder: chg_$1/target_potential/$2
	fi
}


for i in 0.0 -0.5 -1.0 -1.5 -2.0 -2.5
do
	for k in 1_36 4_36 9_36 16_36 25_36 36_36
	do
		cd /home/theodoros/PROJ_ElectroCat/theodoros/HER/NoCation/H_close_sym/chg_$i/target_potetnial/$k
		check_if_done "$i" "$k"
	done
done
