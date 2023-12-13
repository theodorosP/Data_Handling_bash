#! /bin/bash

for i in {0..6..1}
do
	a=$(diff 0$i/POSCAR ../POSCAR.$i)
	if [ -z "$a" ];then
		echo Same 0$i/POSCAR and POSCAR.$i
	else
		echo Different
	fi
done
