#!/bin/sh

if [ -L sysinit.vim ]; then
	rm sysinit.vim
fi
ln -s $PWD/init.vim $PWD/sysinit.vim

if [ "$1" = "-g" ]; then
	if [ -d /etc/xdg/nvim ]; then
		sudo rm -rf /etc/xdg/nvim
	elif [ -L /etc/xdg/nvim ]; then
		sudo rm /etc/xdg/nvim
	fi
	sudo chown -R $(whoami):root "$PWD"
	sudo ln -s "$PWD" /etc/xdg
else
	if [ -d ~/.config/nvim ]; then
		rm -rf ~/.config/nvim
	elif [ -L ~/.config/nvim ]; then
		rm ~/.config/nvim
	fi
	ln -s "$PWD" ~/.config/nvim
fi

#$(cat init.vim) > /etc/xdg/nvim/sysinit.vim
#sudo cat ginit.vim > /etc/xdg/nvim/ginit.vim
#if [ -d /etc/xdg/nvim/lua ]
#then
#rm -rf /etc/xdg/nvim/lua
#fi
#cp -r lua /etc/xdg/nvim
