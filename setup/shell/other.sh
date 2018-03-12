#!/bin/bash

otherapts=(
  "krita"                   # paint tool
  "kazam"                   # screen capture
  "libav-tools imagemagick" # mp4 converter
  "pandoc"                  # markdown convert to docx
  "mysql-server"
  "openssh-server"          # ssh remote access
  "wine-stable"
  "curl"
  "synapse"                 # app launcher
  "growisofs"               # burn ISO image
  "clamav"                  # security scan
  "screen"                  # split terminal screen
  "xclip"                   # copy to clipboard
  "unar"                    # unzip
  "npm"
  "zsh"
  "terminator"
)
for apt in ${otherapts[@]}; do
  sudo apt-get install $apt -y
done

# デフォルトターミナルの変更
update-alternatives --config x-terminal-emulator
