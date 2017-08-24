#!/bin/bash
# -*- coding: utf-8 -*-

set -eux
: $1 $2 $3

# 対象サイトからHTMLを取得する
wget -r --random-wait $1 || exit 1

# ドメイン名のみ取り出す
dirname=`echo $1 | sed -E "s@https?://@@g" | sed -E "s@/.*@@g"`

# 不要なファイルを削除する
rm $dirname/*.png
rm $dirname/*.jpg
rm $dirname/*.gif
rm $dirname/*.zip

# ディレクトリ内のフォルダを取得
files=`find $dirname | xargs`
for file in $files; do
  if [ -f $file ]; then
    # 文字コードを変換して、別名ファイルで出力
    html=`cat $file | iconv -f $2 -t $3`
    title=`echo $html | sed -e "s@.*<title>\(.*\)</title>.*@\1@g"`

    cat $file | iconv -f SJIS -t UTF-8 \
      | sed -E 's@<[^>]*>@@g' \
      | sed -E 's@(^ +| +$)@@g' > "${dirname}/${title}.html"

    # 元のファイルを削除
    rm $file
  fi
done

