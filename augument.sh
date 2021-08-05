#!/bin/sh
if [ ! -d ~/.local ]
then
    mkdir ~/.local
fi
if [ ! -d ~/.local/share ]
then
    mkdir ~/.local/share
fi
if [ ! -d ~/.local/share/nvim ]
then
    mkdir ~/.local/share/nvim
fi

if [ ! -d ~/.config/nvim]
then
    mkdir ~/.config/nvim
fi
rm ~/.local/share/nvim/init.vim
rm ~/.vimrc
rm ~/.config/init.vim
ln -s $PWD/init.vim ~/.local/share/nvim/init.vim
ln -s $PWD/init.vim ~/.vimrc
ln -s $PWD/init.vim ~/.config/nvim/init.vim
