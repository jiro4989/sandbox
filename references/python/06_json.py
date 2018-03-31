#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 標準入力で渡されたjsonデータから任意のキーで値を取り出す

import sys, json

def main():
    json_data = json.load(sys.stdin, encoding="utf-8")
    print(json_data["key"])

if __name__ == '__main__':
    main()
