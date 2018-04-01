#!/bin/bash
# -*- coding: utf-8 -*-

# ディレクトリ内のファイル名を統一。
# ディレクトリ名_%04d.pngに変更

set -eu

# 名前重複を回避するために、tmp拡張子をつけた名前に変更
tardirs=`find . -maxdepth 1 -mindepth 1 -type d | sort`
for dirname in $tardirs; do
  imgs=`ls $dirname | grep .png`
  idx=1
  for img in $imgs; do
    len=${#dirname}
    ci=$((len - 3))
    fn=`echo $dirname | cut -c 1-$ci`
    newname=`printf "${fn}_%04d.png" $idx`
    #printf "$img $newname\n"

    inname=$dirname/$img
    outname=$dirname/$newname
    mv $inname ${outname}.tmp
    idx=$((idx + 1))
  done
done

# 正しい名前に戻す
for dirname in $tardirs; do
  imgs=`ls $dirname | grep .tmp`
  for img in $imgs; do
    inname=$dirname/$img
    outname=$dirname/${img%.*}
    mv $inname $outname
  done
done
