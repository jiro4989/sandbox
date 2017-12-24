#!/bin/bash

apts=(
  "python3-pip"
  "python3-tk"
)
for apt in ${apts[@]}; do
  sudo apt-get install $apt -y
done

