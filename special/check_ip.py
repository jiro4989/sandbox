#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, subprocess, time, re
from urllib.request import urlopen
from urllib.parse import urlencode

def main():
    # IP情報の載ったファイルを読み込む
    ips = []
    with open(sys.argv[1]) as ipfile:
        ip = ipfile.readline()
        while ip:
            ips.append(ip)
            ip = ipfile.readline()

    url = "http://www.cman.jp/network/support/go_ip.cgi"

    p = re.compile(r".*（([^）]*)）.*")
    for target in ips:
        data = { "inServer": target }
        data = urlencode(data).encode(encoding="utf-8")
        with urlopen(url=url, data=data) as resp:
            line = resp.readline().decode("utf-8")
            d = {}
            while line:
                line = resp.readline().decode("utf-8")
                if line.startswith("descr"):
                    d["descr"] = line.strip().replace("\n", "")
                elif line.startswith("country"):
                    d["country"] = line.strip().replace("\n", "")
                elif line.startswith("inetnum"):
                    d["inetnum"] = line.strip().replace("\n", "")
            sys.stdout.write(target)

            sys.stdout.write("\t")
            try:
                text = d["descr"].replace("descr:", "").strip()
                sys.stdout.write(text)
            except:
                sys.stdout.write("none")

            sys.stdout.write("\t")
            try:
                text = d["country"].replace("country:", "").strip()
                m = p.search(text)
                sys.stdout.write(m.group(1))
            except:
                sys.stdout.write("none")
            sys.stdout.write("\t")
            try:
                text = d["inetnum"].replace("inetnum:", "").strip()
                sys.stdout.write(text)
            except:
                sys.stdout.write("none")

            print()
        time.sleep(1*60)

if __name__ == '__main__':
    main()

