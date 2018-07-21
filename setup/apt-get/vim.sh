#!/bin/bash

sudo apt-get install -y vim
sudo apt-get install -y vim-gnome

github="https://github.com"
git clone $github/jiro4989/dotfiles.git ~/dotfiles
mkdir ~/dotfiles/bundle
git clone $github/VundleVim/Vundle.vim.git ~/dotfiles/bundle/Vundle.vim
ln -sf ~/dotfiles/vim/ ~/.vim
