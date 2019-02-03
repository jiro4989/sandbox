#!/bin/bash

# rename_stands_dirname_to_stand.sh はディレクトリ名を変更します。

set -eu

find actor* -maxdepth 1 -type d | grep stand | while read -r f
do
  ndn=`echo "$f" | sed -r 's@(.*)(.)@\1@g'`
  mv "$f" "$ndn"
done
