#!/bin/bash

# dockerコマンドにsudo権限の付与
# dockerグループにsudo権限のあるユーザを追加する
sudo groupadd docker
sudo gpasswd -a $USER docker
