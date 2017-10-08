#!/bin/bash
# -*- coding: utf-8 -*-

# すべての画像ファイルをsummaryディレクトリにコピー

set -eu

dirs=`find . -maxdepth 1 -mindepth 1 -type d | grep ubunch | sort`
for d in $dirs; do
  files=`ls $d | grep .png`
  for f in $files; do
    printf "./summary/$f\n"
    infile=$d/$f
    outfile=./summary/$f
    cp $infile $outfile
  done 
done

