#!/bin/bash

# bashなんてファイル操作してなんぼなんで
# わざわざ書くまでもないか...

# ディレクトリ配下のファイルを連結して確認
find . -type f | xargs cat | less

# 再帰的に大文字小文字無視でwordを検索
grep -r -i word * | less
