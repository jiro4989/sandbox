#!/bin/bash

# フォント
# フォント名は 'Ricty Diminished'
sudo apt-get install -y fonts-ricty-diminished

sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y atom

# デフォルトターミナルの変更
update-alternatives --config x-terminal-emulator

sudo apt-get install -y ibus-mozc
