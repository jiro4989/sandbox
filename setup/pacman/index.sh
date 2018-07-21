#!/bin/bash

# Need too long time
sudo pacman -Syyu

./common/index.sh pacman/install.sh

# 手動でないとだめな箇所があるため
./pacman/others.sh
