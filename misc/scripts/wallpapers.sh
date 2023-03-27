#!/bin/sh
#
while (true)
do
    sleep 4
    LOOP_COUNT=1

    ls -1 ~/Obrazy/Wallpapers | grep -v webp  | grep -v mp4 | while read each
do
    if [ $(expr $LOOP_COUNT % 2 ) != "0" ]
    then
        hyprctl hyprpaper preload "~/Obrazy/Wallpapers/$each"
        sleep 1
        hyprctl hyprpaper wallpaper "$2,~/Obrazy/Wallpapers/$each"
    else
        hyprctl hyprpaper preload "~/Obrazy/Wallpapers/$each"
        sleep 1
        hyprctl hyprpaper wallpaper "$3,~/Obrazy/Wallpapers/$each"
        sleep $1
        hyprctl hyprpaper unload all
    fi

    LOOP_COUNT=$((LOOP_COUNT+1))
done
done