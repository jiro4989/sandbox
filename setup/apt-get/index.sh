#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

./common/index.sh apt-get/install.sh
./apt-get/docker.sh
./apt-get/env.sh

# 手動でないとだめな箇所があるため
./apt-get/others.sh
