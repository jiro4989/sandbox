#!/bin/bash

# 概要
#   イラストディレクトリ内のイラストを書いた枚数を年単位で集計する

find $HOME/Pictures/Picture -type f |
  grep -E '\.(sai|xcf|xpg)$' |
  xargs ls --full-time 2>/dev/null |
  awk '{print $6,$9}' |
  sed -r 's@^(.*)-[0-9]+-[0-9]+ @\1 @g' |
  awk '{m[$1]++} END{for (key in m){print key,m[key]}}' |
  sort |
  awk 'BEGIN{print "date","count"; print "-------", "---"} {print $0; sum+=$2} END{print "-------", "---"; print "total", sum}' |
  column -t
