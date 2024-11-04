#!/bin/sh
#

while read -r A B; do
    hyprctl dispatch exec "$A"
    while ! [ "$(hyprctl clients | grep -i "$A")" ]; do
        sleep 1
    done
    sleep 2
    hyprctl dispatch focuswindow "$A"
    sleep 0.5
    hyprctl dispatch movetoworkspacesilent "$B"
    sleep 0.5
    hyprctl dispatch workspace 1
done <~/.config/hypr/autostart_list.txt

sleep 1

sh $(dirname $0)/gqrx-watchdog.sh &
