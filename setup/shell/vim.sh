#!/bin/bash

sudo apt-get install -y vim
sudo apt-get install -y vim-gnome

github="https://github.com"
git clone $github/jiro4989/dotfiles.git ~/dotfiles
git clone $github/Shougo/dein.vim.git ~/dotfiles/vim/dein
ln -sf ~/dotfiles/vim/ ~/.vim
