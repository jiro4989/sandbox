#!/bin/bash

sudo apt-get install -y \
  krita \
  kazam \
  libav-tools \
  imagemagick \
  pandoc \
  mysql-server \
  openssh-server \
  wine-stable \
  curl \
  synapse \
  growisofs \
  clamav \
  screen \
  xclip \
  unar \
  npm \
  zsh \
  terminator \
  build-essential \
  libgl1-mesa-dev \
  tmux

# デフォルトターミナルの変更
update-alternatives --config x-terminal-emulator
