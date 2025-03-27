#!/usr/bin/env bash
# monitor=DP-1,1920x1080@240,0x0,auto #toggleme
CONFIG_FILE=~/.config/hypr/resolution.conf
# if  monitor=DP-1,1920x1080@240,0x0,auto #toggleme
# toggle to monitor=DP-1,1920x1080@240,0x0,auto #toggleme
# and vice versa
FILE_CONTENT=$(cat $CONFIG_FILE)
if [[ $FILE_CONTENT == *"monitor=DP-1,1920x1080@240,0x0,auto #toggleme"* ]]; then
  sed -i 's/monitor=DP-1,1920x1080@240,0x0,auto #toggleme/monitor=DP-1,1920x1080@60,0x0,auto/g' $CONFIG_FILE
else
  sed -i 's/monitor=DP-1,1920x1080@60,0x0,auto/monitor=DP-1,1920x1080@240,0x0,auto #toggleme/g' $CONFIG_FILE
fi
