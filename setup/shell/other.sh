#!/bin/bash

sudo apt-get install -y krita
sudo apt-get install -y kazam
sudo apt-get install -y libav-tools
sudo apt-get install -y pandoc
sudo apt-get install -y openssh-server
sudo apt-get install -y curl
sudo apt-get install -y synapse
sudo apt-get install -y growisofs
sudo apt-get install -y clamav
sudo apt-get install -y screen
sudo apt-get install -y xclip
sudo apt-get install -y unar
sudo apt-get install -y npm
sudo apt-get install -y zsh
sudo apt-get install -y terminator
sudo apt-get install -y dropbox
sudo apt-get install -y tmux
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y plantuml
sudo apt-get install -y tree
sudo apt-get install -y nkf

sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y atom

# デフォルトターミナルの変更
update-alternatives --config x-terminal-emulator
