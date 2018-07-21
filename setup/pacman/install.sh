#!/bin/bash

# Need too long time
# sudo pacman -Syyu

# Input method for Japanese
sudo pacman -S fcitx-mozc fcitx-gtk2 fcitx-gtk3 fcitx-qt4

# Programming Languages
sudo pacman -S go
sudo pacman -S jdk10-openjdk
sudo pacman -S kotlin
sudo pacman -S nodejs
sudo pacman -S python3
sudo pacman -S ruby

# Web browser
sudo pacman -S chromium

# Editor
sudo pacman -S atom

# Docker
sudo pacman -S docker
sudo pacman -S docker-compose
## dockerコマンドにsudo権限の付与
## dockerグループにsudo権限のあるユーザを追加
sudo groupadd docker
sudo gpasswd -a $USER docker
