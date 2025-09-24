#!/bin/sh

DEVICE="22:22:8E:85:5A:E5"

if [ -z "$(bluetoothctl devices Connected | grep "$DEVICE")" ]; then
    bluetoothctl connect "$DEVICE"
    sleep 1
fi

if [ ! -z "$(echo -e "menu player\nshow" | bluetoothctl | grep "Status: playing")" ]; then
    echo -e "menu player\npause" | bluetoothctl | grep "Status: playing"
else
    echo -e "menu player\nplay" | bluetoothctl | grep "Status: playing"
fi
