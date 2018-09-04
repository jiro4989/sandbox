#!/bin/bash

set -eu

source ./install.conf
pacman -Qqe | grep -v "$(pacman -Qmq)" > $PKGLIST

