#!/bin/sh
#
if [ ! -z "$(echo -e "menu player\nshow" | bluetoothctl | grep "Status: playing")" ]
then
    echo -e "menu player\npause" | bluetoothctl | grep "Status: playing"
else
    echo -e "menu player\nplay" | bluetoothctl | grep "Status: playing"
fi
