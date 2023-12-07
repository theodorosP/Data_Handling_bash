#! /bin/bash


check_file()
{
	local word_to_check="$1" 
	local file="$2"
	a=`grep $word_to_check $file|tail -1`
	echo $a
}

repeat_string()
{
	local string="$1"
	count=30
	for ((i = 0; i < $count; i++))
	do
		echo -n "$string"
	done
}


dir=`ls -d */`
while true
do
	for i in $dir
	do
		pwd
		cd $i
		check_file "Iter" "OUTCAR"
		cd ../
	done
	repeat_string "****"
	echo 
	sleep 10
done

