#!/bin/sh
if [ ! -f ~/.local ]
then
    mkdir ~/.local
fi
if [ ! -f ~/.local/share ]
then
    mkdir ~/.local/share
fi
if [ ! -f ~/.local/share/nvim ]
then
    mkdir ~/.local/share/nvim
fi
ln -s init.vim ~/.local/share/nvim/init.vim
ln -s init.vim ~/.vimrc
