#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, subprocess, time, re
from urllib.request import urlopen
from urllib.parse import urlencode

def main():
    targets = [
            "78.111.161.100",
            "59.169.189.235",
            "218.26.72.34",
            "115.231.218.25",
            "115.231.218.25",
            "118.184.40.225",
            "27.84.172.209",
            "118.184.40.225",
            "123.57.148.247",
            "223.4.152.102",
            "13.115.0.80",
            "13.115.0.80",
            "13.115.0.80",
            "13.115.0.80",
            "13.115.0.80",
            "13.115.0.80",
            "13.115.0.80",
            "13.115.0.80",
            "188.85.49.34",
            "223.4.152.102",
            "54.193.72.62",
            "54.193.72.62",
            "59.169.189.235",
            "79.238.253.164",
            "23.235.173.95",
            "58.120.27.153",
            "222.162.121.201",
            "75.126.34.3",
            "23.248.219.88",
            "118.189.145.226",
            "118.189.145.226",
            "201.183.237.8",
            "60.191.107.134",
            "220.115.18.5",
            "118.189.145.226",
            "118.189.145.226",
            "221.195.111.202"
            ]
    url = "http://www.cman.jp/network/support/go_ip.cgi"

    p = re.compile(r".*（([^）]*)）.*")
    for target in targets:
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

