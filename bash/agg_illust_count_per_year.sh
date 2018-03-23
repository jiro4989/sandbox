#!/bin/bash

# 概要
#   イラストディレクトリ内のイラストを書いた枚数を年単位で集計する

find $HOME/Pictures/Picture/ -type f |
  grep -vE "\.(png|jpg|txt|zip|exe|xml|lnk|~)$" |
  xargs ls -l 2> /dev/null |
  sort -k8n -k6n -k7n |
  awk '{print $8"年", $6, $7"日", $9}' |
  awk 'BEGIN{print "No","Count"} {map[$1]++} END { for (key in map) { sum+=map[key]; print key, map[key] }}' |
  sort -k1n |
  column -t |
  tee >(awk '{sum+=$2} END{print "合計", sum"枚"}') |
  column -t
