#!/bin/bash

set -eu

find Character* -type d | grep Stand | while read -r f
do
  d=`dirname "$f"`
  mv "$f" "$d/stand"
done

find Character* -type d | grep Faces | while read -r f
do
  d=`dirname "$f"`
  mv "$f" "$d/face"
done
