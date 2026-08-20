#!/usr/bin/env bash
#
# hyprctl dispatch 'hl.dsp.exec_cmd("ydotoold")'
while true; do
    while [ ! -f /tmp/wakeup ]; do
        sleep 1
    done
    echo "DONE!!!"
    rm /tmp/wakeup
    ~/skrypty/gqrx-dispatcher.sh &
    sleep 1
done
