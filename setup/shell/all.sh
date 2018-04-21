#!/bin/bash

# パッケージリストの更新
sudo apt-get update -y

# 各種パッケージのインストール
d=`dirname ${0}`

bash $d/env.sh
bash $d/go.sh
bash $d/java.sh
bash $d/kotlin.sh
bash $d/python.sh
bash $d/vim.sh
bash $d/music.sh
bash $d/other.sh

# インストールしたパッケージのアップグレード
sudo apt-get upgrade -y

# Ubuntuカーネルのアップグレード
sudo apt-get dist-upgrade -y
