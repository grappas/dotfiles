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
rm ~/.local/share/nvim/init.vim
rm ~/.vimrc
ln -s init.vim ~/.local/share/nvim/init.vim
ln -s init.vim ~/.vimrc
