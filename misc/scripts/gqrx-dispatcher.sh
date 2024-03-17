#!/bin/sh

sh ~/skrypty/sftp_mount.sh armalauncher 192.168.0.150 /home/eftepe2 &
sh ~/skrypty/sftp_mount.sh armalauncher 192.168.0.150 /home/eftepe3 &
sh ~/skrypty/sftp_mount.sh jakub 192.168.0.150 /home/jakub &

WORKSPACE_CACHE=$(hyprctl activewindow | grep workspace | sed 's/^.*workspace:\ //g' | sed 's/\ (*.*)//g')

# kill -s TERM $(pidof gqrx)
hyprctl dispatcher workspace 3
sleep 1
if [ ! -z "$(hyprctl clients | grep Gqrx)" ]; then
	hyprctl dispatcher focuswindow gqrx && hyprctl dispatcher killactive
	sleep 1
	while [ ! -z "$(hyprctl clients | grep Gqrx)" ]; do
		sleep 0.3
	done
fi
~/instalancje/gqrx/src/gqrx&

while ! ([ "$(hyprctl clients | grep Gqrx)" ] || [ "$(hyprctl clients | grep 'Crash Detected!')" ]); do
	sleep 0.3
done

sleep 0.3

if [ -n "$(hyprctl clients | grep 'Crash Detected!')" ]; then
	hyprctl dispatch focuswindow gqrx && hyprctl dispatch movecursortocorner 1 && ydotool mousemove -x -35 -y -50 && ydotool click 0xC0
fi

sleep 0.3

while ! ([ "$(hyprctl clients | grep Gqrx)" ] || [ "$(hyprctl clients | grep 'Crash Detected!')" ]); do
	sleep 0.3
done

sleep 1

hyprctl dispatch focuswindow gqrx && hyprctl dispatch movecursortocorner 3 && sleep 0.3 && ydotool mousemove -x 35 -y 50 && sleep 0.3 && ydotool click 0xC0 && sleep 0.3 && hyprctl dispatch movecursortocorner 1 && sleep 0.3 && ydotool mousemove -x -200 -y -100 && sleep 0.3 && ydotool click 0xC0

sleep 0.5

alacritty -e ~/instalancje/gqrx-scanner/bin/gqrx-scanner -v -m bookmark -t "Moje|Add" -q a4.0 -x 50 --udp_listen &

sleep 0.5

hyprctl dispatch workspace "$WORKSPACE_CACHE"
