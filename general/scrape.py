#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u"標準入力から渡されたHTMLに対して、CSSセレクタと属性の指定で要素を取得する"

from bs4 import BeautifulSoup as BS
import sys, argparse

def main():
    u"""\
    -a オプションを指定すると属性を出力する
    -a オプションを指定しないと、CSSセレクタでマッチした要素を出力する
    """

    args = _get_args()
    selector = args.selector
    attribute = args.attribute

    stdin = sys.stdin.read()
    soup = BS(stdin, "html.parser")
    if attribute != None:
        for l in soup.select(selector):
            attr = l.get(attribute)
            print(attr)
    else:
        for l in soup.select(selector):
            print(l)

def _get_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("-s", "--selector", type=str
            , help=u"要素を特定するためのCSSセレクタ")
    parser.add_argument("-a", "--attribute", type=str
            , help=u"取得する属性")

    return parser.parse_args()

if __name__ == '__main__':
    main()

