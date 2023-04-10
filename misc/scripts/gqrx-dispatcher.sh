#!/bin/sh

sh ~/skrypty/sftp_mount.sh armalauncher 192.168.0.150 /home/eftepe2
sh ~/skrypty/sftp_mount.sh armalauncher 192.168.0.150 /home/eftepe3
sh ~/skrypty/sftp_mount.sh jakub 192.168.0.150 /home/jakub

kill -s TERM $(pidof gqrx)

sleep 1

WORKSPACE_CACHE=$( hyprctl activewindow | grep workspace | sed 's/^.*workspace:\ //g' | sed 's/\ (*.*)//g' )

hyprctl dispatch workspace 3

gqrx &

sleep 1

while ! ( [ "$(hyprctl clients | grep Gqrx)" ] || [ "$(hyprctl clients | grep 'Crash Detected!')" ] )
do
    sleep 1
done

sleep 0.3

if [ -n "$(hyprctl clients | grep 'Crash Detected!')" ]
then
    hyprctl dispatch focuswindow gqrx && hyprctl dispatch movecursortocorner 1 && ydotool mousemove -x -35 -y -50 && ydotool click 0xC0
fi

sleep 0.3

while ! ( [ "$(hyprctl clients | grep Gqrx)" ] || [ "$(hyprctl clients | grep 'Crash Detected!')" ] )
do
    sleep 1
done

sleep 0.3

hyprctl dispatch focuswindow gqrx && hyprctl dispatch movecursortocorner 3 && ydotool mousemove -x 35 -y 50 && ydotool click 0xC0

sleep 0.5

wezterm start -- ~/instalancje/gqrx-scanner/bin/gqrx-scanner -m bookmark -t "Moje" -q a3.0 -x 150&

sleep 0.5

hyprctl dispatch workspace "$WORKSPACE_CACHE"
