#!/bin/bash
# -*- coding: utf-8 -*-

# 各話ごとにフォルダ分けされていたZIPを展開

set -eu

zips=`ls *.zip`
for file in $zips; do
  name=${file%.*}
  unzip $file -d $name
done

