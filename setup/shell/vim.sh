#!/bin/bash

mkdir ~/tmp

# vimのインストール {{{
apts=(
  "vim"
  "vim-gnome"
)
for apt in ${apts[@]}; do
  sudo apt-get install $apt -y
done
#}}}
# 必要リポジトリのcloneの取得 {{{
github="https://github.com"
git clone $github/jiro4989/dotfiles.git ~/dotfiles
git clone $github/Shougo/dein.vim.git ~/dotfiles/vim/dein
ln -sf ~/dotfiles/vim/ ~/.vim
#}}}
# rcファイルのシンボリックリンクの作成 {{{
rcs=(
  ".vimrc"
  ".gvimrc"
  ".vimperatorrc"
  ".vrapperrc"
)
for rc in ${rcs[@]}; do
  ln -sf ~/.vim/rc/.$rc ~/.$rc
done
#}}}
# tomlファイルの配置 {{{
mkdir -p ~/.config/vim
ln -sf ~/$vimdir/rc/dein
#}}}
