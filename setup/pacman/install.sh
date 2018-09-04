#!/bin/bash

set -eu

source ./install.conf
pacman -Syu $(cat $PKGLIST) --noconfirm
