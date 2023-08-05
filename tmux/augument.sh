#!/bin/sh

if [ -d ~/.config/tmux ]; then
	rm -rf ~/.config/tmux
elif [ -L ~/.config/tmux ]; then
	rm ~/.config/tmux
fi

ln -s "$PWD" ~/.config
