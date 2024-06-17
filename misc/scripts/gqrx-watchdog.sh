#!/bin/sh
#
hyprctl dispatcher exec ydotoold
while [ true ]
do
    while [ ! -f ~/temp/wakeup ]
    do
        sleep 1
    done
    echo "DONE!!!"
    rm ~/temp/wakeup
    sh ~/skrypty/gqrx-dispatcher.sh&
    sleep 1
done
