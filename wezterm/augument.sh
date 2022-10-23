#!/bin/sh

if [ -d ~/.config/wezterm ]
then
    rm -rf ~/.config/wezterm
elif [ -L ~/.config/wezterm ]
then
    rm ~/.config/wezterm
fi

ln -s "$PWD" ~/.config
