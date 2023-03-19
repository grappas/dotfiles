#!/bin/sh

BLACHA=0
for each in $(zenmonitor-cli -o | grep -i frequency | sed 's/Core\ [0-9]\ Frequency\t//g' | sed 's/\.//g' | sed 's/...$//g')
do
    if [ $BLACHA -le $each ]
    then
        BLACHA=$each
    fi
done
echo $BLACHA
