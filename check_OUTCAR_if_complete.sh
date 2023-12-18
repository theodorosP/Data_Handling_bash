#! /bin/bash

a=`ls -d */`
for i in $a
do
    cd $i
    find=`grep "General timing and accounting informations for this job:" OUTCAR`
    if [ -z "$find" ]
    then
        echo job not COMPLETE, folder: $i''OUTCAR
    else
        echo job is COMPLETE $i''OUTCAR
    fi
	cd ../
done
