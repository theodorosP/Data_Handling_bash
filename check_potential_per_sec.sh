#! /bin/bash

#this function repeats a string, use it as a sheperator
repeat_string()
{
    local string="$1"
    count=40
    for ((i = 0; i < $count; i++)); do
        echo -n "$string"
    done
    echo ""
}


get_status()
{
local string="$1"
while true
do
if grep -q "CURRENT PO" OUTCAR; then
    grep "CURRENT PO" OUTCAR
    repeat_string "--"
    sleep "$string"
else
    echo First iteration is not completed yet.
    repeat_string "--"
    sleep "$string"
fi
done
}

#check every 10 seconds
get_status "10"


