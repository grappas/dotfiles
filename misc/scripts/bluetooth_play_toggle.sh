#!/bin/sh

if [ -z "$(bluetoothctl devices Connected | grep 8C:7A:3D:D2:BF:A6)" ]
then
    bluetoothctl connect 8C:7A:3D:D2:BF:A6
    sleep 1
fi

if [ ! -z "$(echo -e "menu player\nshow" | bluetoothctl | grep "Status: playing")" ]
then
    echo -e "menu player\npause" | bluetoothctl | grep "Status: playing"
else
    echo -e "menu player\nplay" | bluetoothctl | grep "Status: playing"
fi
