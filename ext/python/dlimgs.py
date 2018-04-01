#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from bs4 import BeautifulSoup as BS
from urllib.request import urlopen
import time, re, sys

def main():
    args = sys.argv
    if len(args) < 5:
        print("need 5 arguments")
        return

    url     = args[1]
    filter1 = args[2]
    filter2 = args[3]
    filter3 = args[4]

    # 元のHTMLを取得
    with urlopen(url) as resp:
        html = resp.read().decode("utf-8")

    # HTMLの中から必要なURLのみ取得
    soup = BS(html, "html.parser")
    srcs = [l for l in soup.select("a")]
    urls = []
    for imgurl in srcs:
        imgs = imgurl.select("img")
        if 0 < len(imgs):
            for img in imgs:
                alt = img.get("alt")
                if alt != None:
                    if filter1 in alt:
                        tmp = [imgurl, alt]
                        urls.append(tmp)
                        print(alt)
                    elif filter2 in alt:
                        tmp = [imgurl, alt]
                        urls.append(tmp)
                        print(alt)
                    elif filter3 in alt:
                        tmp = [imgurl, alt]
                        urls.append(tmp)
                        print(alt)

    # URL先のデータを取得してきて保存
    for tup in urls:
        # 数字を0埋めする
        name = tup[1]
        p = re.compile(r"([^\d]*)(\d+)(.*)")
        m = p.search(name)
        result1 = m.group(1)
        result2 = m.group(2)
        result3 = m.group(3)
        newname = result1 + ("%03d" % int(result2)) + result3

        url = tup[0].get("href")
        with urlopen(url) as img:
            if url.endswith(".jpg"):
                fn = newname + ".jpg"
            elif url.endswith(".png"):
                fn = newname + ".png"
            else:
                continue
            fn = fn.replace(" ", "_")
            with open(fn, "wb") as outfile:
                outfile.write(img.read())
            print("success: saving " + fn)
        time.sleep(0.5)

if __name__ == '__main__':
    main()


