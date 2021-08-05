#!/bin/sh
if [ ! -f /home/$USER/.local ]
then
    mkdir /home/$USER/.local
fi
if [ ! -f /home/$USER/.local/share ]
then
    mkdir /home/$USER/.local/share
fi
if [ ! -f /home/$USER/.local/share/nvim ]
then
    mkdir /home/$USER/.local/share/nvim
fi
