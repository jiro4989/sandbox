#!/bin/bash

GIT=https://github.com
MY_GITHUB=$GIT/jiro4989
DOTFILES_DIR=$HOME/dotfiles
BUNDLE_DIR=$DOTFILES_DIR/vim/bundle

git clone $MY_GITHUB/dotfiles.git $DOTFILES_DIR
mkdir $BUNDLE_DIR
git clone $GIT/VundleVim/Vundle.vim.git $BUNDLE_DIR/Vundle.vim
ln -sf $DOTFILES_DIR/vim/ $HOME/.vim
