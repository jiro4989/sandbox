#!/bin/bash

# キーリピート
xset r rate 300 62

# ユーザフォルダの日本語を英語に変更
LANG=C xdg-user-dirs-gtk-update

mkdir ~/Documents/note
mkdir ~/workspace
mkdir ~/workspace/proj
git clone https://github.com/jiro4989/scripts.git ~/workspace/scripts

# ビープ音を無効化
sudo echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf

# bashrcの設定を追加
echo "source ~/dotfiles/.bashrc.jiro" >> ~/.bashrc

