#!/bin/bash

# 参照元ディレクトリ
vimdir="dotfiles"
github="https://github.com"

apts=(
  "vim"
  "vim-gnome"
)
for apt in ${apts[@]}; do
  sudo apt-get install $apt -y
done

git clone $github/jiro4989/$vimdir.git ~/$vimdir

dirs=(
  "~/tmp"
  "~/.vim"
  "~/$vimdir/bundle"
)
for dir in $dirs; do
  mkdir $dir
done

git clone $github/Shougo/dein.vim.git ~/$vimdir/bundle/dein.vim

# 各種設定フォルダのシンボリックリンクの作成
symlinks=(
  ".vimrc"
  ".gvimrc"
  ".vimperatorrc"
)
for symlink in $symlinks; do
  ln -sf ~/$vimdir/$symlink ~/$symlink
done

symlinks=(
  "bundle"
  "dict"
  "vimfiles"
  "colors"
  "template"
)
for symlink in $symlinks; do
  ln -sf ~/$vimdir/$symlinks ~/.vim
done

