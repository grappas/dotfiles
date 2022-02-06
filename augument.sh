#!/bin/sh

sudo echo "\" source /usr/share/nvim/archlinux.vim
$(cat init.vim)" > /etc/xdg/nvim/sysinit.vim
sudo cat ginit.vim > /etc/xdg/nvim/ginit.vim
