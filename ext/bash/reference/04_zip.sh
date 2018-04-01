#!/bin/bash

# 圧縮 compress
tar czf target.tar.gz target

# 展開 extract だったかな
tar xzf target.tar.gz

# .gzのみのファイルの展開
# こっちのほうがいっつも忘れる...
gunzip target.gz
# http://tech.nikkeibp.co.jp/it/article/COLUMN/20060227/230790/
