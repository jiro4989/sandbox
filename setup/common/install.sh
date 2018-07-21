#!/bin/bash

# Usage:
#   ./common/install.sh common/pkg.list pacman -S
#   ./common/install.sh common/pkg.list apt-get install
#
# Arguments:
#   Ubuntu -> sudo apt-get install
#   ManjaroLinux -> sudo pacman -S

LIST=$1
CMD=$2
OPTIONS=${@:3:$#-2}

cat $LIST | while read -r pkg
do
  sudo $CMD ${OPTIONS[@]} $pkg
done
