#!/bin/bash

# 概要
#   bashの連番ファイルをテンプレに各拡張子のファイルを作成する

set -eu

ext=$1

find bash/ -type f |
  while read -r f do basename `echo ${f%.*}` done |
    while read -r f do touch $ext/$f.$ext done
