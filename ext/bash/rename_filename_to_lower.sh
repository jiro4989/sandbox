#!/bin/bash

# rename_filename_to_lower.sh.sh はファイル名を大文字から小文字に変更します。

set -eu

find . -type f | grep .png | while read -r f
do
  nf=`echo "$f" | tr "[:upper:]" "[:lower:]"`
  mv "$f" "$nf"
done
