#!/bin/bash

sudo apt-get install -y emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -sf $HOME/dotfiles/.spacemacs $HOME/.emacs.d/