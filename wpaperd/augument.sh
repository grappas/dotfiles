#!/bin/sh

if [ -d ~/.config/wpaperd ]; then
	rm -rf ~/.config/wpaperd
elif [ -L ~/.config/wpaperd ]; then
	rm ~/.config/wpaperd
fi
ln -s "$PWD" ~/.config/wpaperd

#$(cat init.vim) > /etc/xdg/wpaperd/sysinit.vim
#sudo cat ginit.vim > /etc/xdg/wpaperd/ginit.vim
#if [ -d /etc/xdg/wpaperd/lua ]
#then
#rm -rf /etc/xdg/wpaperd/lua
#fi
#cp -r lua /etc/xdg/wpaperd
