#!/bin/sh
#
hyprctl dispatcher exec ydotoold
while [ true ]; do
    while [ ! -f ~/temp/wakeup ]; do
        sleep 1
    done
    echo "DONE!!!"
    rm ~/temp/wakeup
    uwsm app -- sh ~/skrypty/gqrx-dispatcher.sh &
    sleep 1
done
