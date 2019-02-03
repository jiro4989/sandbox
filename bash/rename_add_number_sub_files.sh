#!/bin/bash

# rename_add_number_sub_files.sh はサブディレクトリのファイル名連番に4加算してリ
# ネームします。

set -eu

find actor* -type f | grep png | sort -r | while read -r f
do
  num=`echo $f | sed -r 's@.*actor([0-9]+)_.*@\1@g'`
  num=`expr $num + 4`
  num=`printf '%03d' $num`
  mv $f `echo $f | sed -r 's@(.*actor)([0-9]+)(_.*)@\1'$num'\3@g'`
done
