#!/bin/bash

set -eu

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
mkdir -p $HOME/.config/nvim
ln -sf $HOME/.vim/vimrc $HOME/.config/nvim/init.vim
