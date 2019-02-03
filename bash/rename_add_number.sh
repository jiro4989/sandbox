#!/bin/bash

# rename_add_number.sh はディレクトリ名の連番に加算して変更します。
# mvするときに逆順sortしておかないと失敗する

set -eu

find . -maxdepth 1 -type d | grep actor | sort -r | while read -r f
do
  num=`echo $f | sed -r 's@.*actor@@g'`
  num=`expr $num + 4`
  num=`printf '%03d' $num`
  mv $f actor$num
done
