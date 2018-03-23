#!/bin/bash

# 概要
#   イラストディレクトリ内のイラストを書いた枚数を月単位で集計する

find $HOME/Pictures/Picture/ -type f |
  grep -vE "\.(png|jpg|txt|zip|exe|xml|lnk|~)$" |
  xargs ls -l 2> /dev/null |
  sort -k8n -k6n -k7n |
  awk '{print $8"年", $6, $7"日", $9}' |
  awk 'BEGIN{print "No","Month","Count"} {map[$1" "$2]++} END { for (key in map) { sum+=map[key]; print key, map[key] }}' |
  sort -k1n -k2n |
  column -t |
  tee >(awk '{sum+=$3} END{print "_", "合計", sum"枚"}') |
  column -t
