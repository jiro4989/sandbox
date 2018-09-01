#!/bin/bash

# Usage:
#   ./common/index.sh pacman/install.sh

SPECIAL_SCRIPT=$1

./"$SPECIAL_SCRIPT"
./common/workspace.sh
./common/go.sh
./common/vim.sh
./common/docker.sh

# キーリピートとディレイを設定
xset r rate 195 30
