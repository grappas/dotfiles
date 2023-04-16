#!/bin/bash
#
LANG=en top -bn1 -w 120 | grep "PID USER" -A 5 | grep -v "PID USER" | while read PID USER PR NI VIRT RES SHR S CPU MEM TIME COMMAND
do
    if [ $(echo $RES | grep "g") ]
    then
        NEW_MEM=$(echo $RES"G" | sed 's/g//g')
    elif (( $(echo -n "$RES" | wc -c) <= 4 ))
    then
        NEW_MEM=$(echo $RES"K")
    else
        NEW_MEM=$(echo $RES"M" | sed 's/...M/M/g')
    fi
    NEW_CPU=$(echo $CPU%)
    printf '​%16.16s %6.6s %6.6s\n' "$COMMAND" $NEW_MEM $NEW_CPU
done
