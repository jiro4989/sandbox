#!/bin/bash

# set -eu

sudo apt-get install -y docker.io

# dockerコマンドにsudo権限の付与
# dockerグループにsudo権限のあるユーザを追加する
sudo groupadd docker
sudo gpasswd -a $USER docker

sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
