#!/usr/bin/env bash
# cycles DP-1 through: 240Hz -- toggleme -> 60Hz -> disabled -> 240Hz -- toggleme ...
# (migrated to the Hyprland Lua config format; see ~/.config/hypr/resolution.lua)
CONFIG_FILE=~/.config/hypr/resolution.lua
FILE_CONTENT=$(cat "$CONFIG_FILE")

DP1_240='hl.monitor({ output = "DP-1", mode = "1920x1080@240", position = "0x0", scale = "auto" }) -- toggleme'
DP1_60='hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = "auto" })'
DP1_OFF='hl.monitor({ output = "DP-1", disabled = true })'
DP3_RIGHT='hl.monitor({ output = "DP-3", mode = "3840x2160", position = "1920x0", scale = 2 })'
DP3_LEFT='hl.monitor({ output = "DP-3", mode = "3840x2160", position = "0x0", scale = 2 })'

if [[ $FILE_CONTENT == *"$DP1_240"* ]]; then
  sed -i "s|$DP1_240|$DP1_60|" "$CONFIG_FILE"
elif [[ $FILE_CONTENT == *"$DP1_60"* ]]; then
  sed -i "s|$DP1_60|$DP1_OFF|" "$CONFIG_FILE"
  sed -i "s|$DP3_RIGHT|$DP3_LEFT|" "$CONFIG_FILE"
else
  sed -i "s|$DP1_OFF|$DP1_240|" "$CONFIG_FILE"
  sed -i "s|$DP3_LEFT|$DP3_RIGHT|" "$CONFIG_FILE"
fi

hyprctl reload >/dev/null 2>&1
