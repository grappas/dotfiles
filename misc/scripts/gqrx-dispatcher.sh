#!/bin/sh
kill -s TERM $(pidof gqrx)
sleep 1
gqrx &

while ! ( [ "$(hyprctl clients | grep Gqrx)" ] || [ "$(hyprctl clients | grep "Crash Detected")" ] )
do
    sleep 1
done

sleep 0.3

if [ -n "$(hyprctl clients | grep "Crash Detected")" ]
then
hyprctl dispatch focuswindow gqrx && hyprctl dispatch movecursortocorner 1 && ydotool mousemove -x -35 -y -50 && ydotool click 0xC0
fi

sleep 0.3

while ! ( [ "$(hyprctl clients | grep Gqrx)" ] || [ "$(hyprctl clients | grep "Crash Detected")" ] )
do
    sleep 1
done

hyprctl dispatch focuswindow gqrx && hyprctl dispatch movecursortocorner 3 && ydotool mousemove -x 35 -y 50 && ydotool click 0xC0

sleep 0.3

wezterm start -- ~/instalancje/gqrx-scanner/bin/gqrx-scanner -m bookmark -t "Moje" -q a3.0 -x 150&

sleep 0.5

hyprctl dispatch focuswindow gqrx-scanner && hyprctl dispatch movetoworkspacesilent 3
hyprctl dispatch focuswindow Gqrx && hyprctl dispatch movetoworkspacesilent 3
