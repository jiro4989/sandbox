#!/bin/bash
# -*- coding: utf-8 -*-

q_url=$1
a_url=$2
filename="gem.html"

html=`curl $q_url`

# 通信に失敗してる場合は、ローカルに保存しておいたhtmlを読み取って実行
if [ 0 -lt $? ]; then
  echo "通信に失敗しました。"

  # 通信失敗時用に保存しておいたhtmlが存在しなければ、
  # プログラム終了
  if [ ! -f $filename ]; then
    echo "通信失敗時用のファイル( $filename )が存在しなかったのでプログラムを終了します。"
    exit 1
  fi

  echo "保存用のファイル( $filename )を読み込みます。"
  html=`cat $filename`
else
  echo "通信に成功しました。"

  # 通信に成功しているので、
  # 取得したデータを保存しておく
  echo "$html" > $filename
fi

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# メイン処理
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# 1. htmlの改行をすべて消す
# 2. テーブルタグで囲われた部分を消す
# 3. 最短一致でgemを検索し、見つけたgemをすべて改行文字に置換する
# 4. 結果の行数を数える
count=`
echo "$html" \
| tr -d '\r' \
| tr -d '\n' \
| sed -E 's@<table[^>]*>.*</table>@@g' \
| sed -E 's@g[^("|e)]*e[^("|m)]*m@\n@g' \
| wc -l`

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# 結果をヘッダに埋め込んでGET
# レスポンスをデコードして出力
curl "$a_url" -H "Gem-Count: $count" | iconv -f SJIS -t UTF8

