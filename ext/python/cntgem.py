#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, re
from urllib.request import urlopen, Request

def main(q_url, a_url):
    with urlopen(q_url) as q_resp:
        # htmlを取得
        html = q_resp.read().decode('utf-8')

        # 改行文字を削除
        html = html.replace('\r', '').replace('\n', '')

        # tableタグ内の要素を削除
        html = re.sub(r'<table[^>]*>.*</table>', '', html)

        # 正規表現にマッチした要素のリストの長さを取得
        # == マッチした要素数
        count = len(re.findall(r'g[^("|e)]*e[^("|m)]*m', html))

        # 結果を返すためにヘッダ追加
        req = Request(a_url)
        req.add_header('Gem-Count', str(count))

        # 結果の確認
        with urlopen(req) as a_resp:
            result = a_resp.read().decode('shift-jis')
            print(result)

if __name__ == '__main__':
    args = sys.argv
    main(args[1], args[2])

