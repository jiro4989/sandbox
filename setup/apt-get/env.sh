#!/bin/bash

# キーリピート
xset r rate 300 62

# ユーザフォルダの日本語を英語に変更
LANG=C xdg-user-dirs-gtk-update

github="$HOME/workspace/github"
gitrepo="$github/repos"
ds=(
  "$github/gist/"
  "$gitrepo/plugins/firefox"
  "$gitrepo/plugins/vim"
)
for d in ${ds[@]}; do
  mkdir -p $d
done

git clone https://github.com/jiro4989/scripts.git $gitrepo/scripts

# ビープ音を無効化
sudo echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf

# bashrcの設定を追加
echo "source ~/dotfiles/.bashrc" >> ~/.bashrc

