#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, re

def main():
    pattern = re.compile(r"\[\[\[(.+)\]\]\]")
    with open(sys.argv[1]) as html:
        lines = []
        line = html.readline()
        p = None
        while line:
            if line.startswith("#"):
                match = re.findall("#+", line)[0]
                count = len(re.findall("#", match))
                text = re.split("^#+", line)[1].strip()
                line = "<h{num}>{text}</h{num}>".format(num=count, text=text)
                sys.stdout.write(line)
            else:
                if p == None:
                    p = "<p>" + line
                elif line == "\n":
                    line = p + line + "</p>"
                    p = None
                    sys.stdout.write(line)
                else:
                    p += line
            lines.append(line)
            line = html.readline()

        text = "\n".join(lines)
        text = pattern.sub(r'<input type="text" value="\1" />', text)
        print(text)

if __name__ == '__main__':
    main()

