#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u"マークダウン形式のテキストの見出しからマークダウン形式の目次を生成する。"

import sys, re

def main():
    lines = []
    args = sys.argv
    with open(args[1]) as mdfile:
        line = mdfile.readline()
        while line:
            if line.startswith("#"):
                count = len(re.findall("#", line))
                line = line.replace("#", "").strip()
                content = [count, line]
                lines.append(content)
            line = mdfile.readline()

    flg = not "-n" in args
    for count, line in lines:
        if 2 <= count and line != "目次":
            indent = "  " * (count - 2)
            fmt = "[{title}]"
            if flg:
                fmt += "(#{title})"
            text = indent + "- " + fmt.format(title=line)
            print(text)

if __name__ == '__main__':
    main()

