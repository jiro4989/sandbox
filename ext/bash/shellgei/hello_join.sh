#!/bin/bash

# ネタシェル芸
# HelloWorldを出力するだけ

w="print "
for i in 34 5 12 12 15 49 15 18 12 4
do
  w="${w}substr(cs, $i, 1)"
done
awk 'BEGIN{cs="'`echo "abcdefghijklmnopqrstuvwxyz" | vim -es /dev/stdin +':norm yypVgUkJ^Whx' +%p +q!`'"; '"$w"'}'

cs=`echo "abcdefghijklmnopqrstuvwxyz" | vim -es /dev/stdin +':norm yypVgUkJ^f x' +%p +q!`
for i in 34 5 12 12 15 49 15 18 12 4
do
  printf ${cs:i-1:1}
done

