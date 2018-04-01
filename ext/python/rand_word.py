#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse, random

def main():
    args = _get_args()

    # テキストファイルから文字をすべて読み込む
    text = []
    with open(args.word_file, encoding="utf-8") as f:
        line = f.readline()
        while line:
            text.append(line)
            line = f.readline()

    text = "".join(text)

    textlist = []
    length = len(text)
    for i in range(0, args.max):
        # 0 ~ 読み込んだ文字数 の範囲の乱数を取得して、文字を取り出す
        r = random.randint(0, length-1)
        textlist.append(text[r])

    print("".join(textlist).replace("\n", ""))

def _get_args():
    parser = argparse.ArgumentParser(description=u'ランダムに文字を選んで連結する')

    parser.add_argument(
            'word_file'
            , type=str
            , help=u'ランダムに選択する対象となるテキストを格納したファイル'
                    )

    parser.add_argument(
            '-m'
            , '--max'
            , type=int
            , default=100
            , help=u'ランダムに生成される文字数の上限'
                    )

    return parser.parse_args()

if __name__ == '__main__':
    main()

