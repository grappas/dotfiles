#!/usr/bin/env bash
#
# hyprctl dispatcher exec ydotoold
while true; do
    while [ ! -f /tmp/wakeup ]; do
        sleep 1
    done
    echo "DONE!!!"
    rm /tmp/wakeup
    uwsm app -- sh ~/skrypty/gqrx-dispatcher.sh &
    sleep 1
done
