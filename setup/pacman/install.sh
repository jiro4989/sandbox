#!/bin/bash

set -eu

source ./install.conf
pacman -S $(cat $PKGLIST)
