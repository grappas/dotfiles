#!/bin/sh
#
while [ true ]
do
    while [ ! -f ~/temp/wakeup ]
    do
        echo "No file."
        sleep 1
    done
    echo "DONE!!!"
    rm ~/temp/wakeup
    sh ~/skrypty/gqrx-dispatcher.sh&
    sleep 1
done
