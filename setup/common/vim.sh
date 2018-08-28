#!/bin/bash

GIT=https://github.com
MY_GITHUB=$GIT/jiro4989
DOTFILES_DIR=$HOME/dotfiles

git clone $MY_GITHUB/dotfiles.git $DOTFILES_DIR
ln -sf $DOTFILES_DIR/vim/ $HOME/.vim
