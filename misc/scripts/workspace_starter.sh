#!/bin/sh
#

cat ~/.config/hypr/autostart_list.txt | while read A B
do
    "$A"&
    while ! [ "$( hyprctl clients | grep -i "$A" )" ]
    do
        sleep 1
    done
    sleep 2
    hyprctl dispatch focuswindow $A
    sleep 0.5
    hyprctl dispatch movetoworkspacesilent $B
    sleep 0.5
    hyprctl dispatch workspace 1
done

sleep 1

sh $(dirname $0)/gqrx-watchdog.sh&
