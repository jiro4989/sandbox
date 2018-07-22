#!/bin/bash

# Usage:
#   ./common/install.sh common/pkg.list pacman -S
#   ./common/install.sh common/pkg.list apt-get install
#
# Arguments:
#   Ubuntu -> apt-get install
#   ManjaroLinux -> pacman -S

LIST=$1
CMD=$2
OPTIONS=${@:3:$#-2}

cat $LIST \
  | grep -Ev "^\s*#" \
  | grep -Ev "^\s*$" \
  | while read -r line
do
  genre=$(echo $line | cut -f 1)
  pkg=$(echo $line | cut -f 2)

  if [ "$genre" = "all" ]; then
    sudo $CMD ${OPTIONS[@]} $pkg
  elif [ "$genre" = "$CMD" ]; then
    sudo $CMD ${OPTIONS[@]} $pkg
  fi
done
