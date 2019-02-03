#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from bs4 import BeautifulSoup as BS
from urllib.request import urlopen
import sys, argparse, re

def main():
    args = sys.argv
    if len(args) < 2:
        region = "(Tokyo)"
    else:
        region = "(" + args[1] + ")"

    url = "http://status.aws.amazon.com/"
    with urlopen(url) as resp:
        html = resp.read().decode("utf-8")

    soup = BS(html, "html.parser")
    hrefptn = re.compile("^/rss/")
    for s in soup.select("table.fullWidth"):
        for td in s.find_all("td", {"class":"bb top pad8"}):
            title = td.text
            if region in title:
                rssurl = s.find("a", href=hrefptn).attrs["href"]
                rssurl = url + rssurl[1:]
                text = "{title}\t{url}".format(title=title, url=rssurl)
                print(text)

if __name__ == '__main__':
    main()


