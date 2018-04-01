#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u"Red Hatのバグ修正情報をかき集めてきてテキストファイルに出力する"

from bs4 import BeautifulSoup as BS
from urllib.request import urlopen, Request
import re, time
from datetime import datetime

def main():
    with open("res.csv", "w", encoding="utf-8") as outfile:
        outfile.write("issue_id\tadvisory\tdesc\tissued_date\tupd_date\ttoday\n")
        for year in [2016, 2017]:
            for idx in range(1, 3000):
                try:
                    results = {}

                    results["issue_id"] = "RHSA-{year:04d}:{idx:04d}".format(year=year,
                            idx=idx)
                    url = "https://access.redhat.com/errata/" + results["issue_id"]
                    with urlopen(url) as resp:
                        html = resp.read().decode("utf-8")

                    lines = html.split("\n")

                    results["advisory"]   = get_advisory(lines)
                    #results["severity"]   = get_severity(lines)
                    results["desc"]       = get_description(lines)
                    results["issued_date"], results["upd_date"] = get_dates(lines)

                    results["today"] = datetime.now().strftime("%Y/%m/%d")
                    result = \
                    u"{issue_id}\t{advisory}\t{desc}\t{issued_date}\t{upd_date}\t{today}\n".format(**results)

                    outfile.write(result)

                    print("OK:", results["issue_id"])
                except:
                    print("NG:", results["issue_id"])

                time.sleep(0.5)

def get_advisory(lines):
    adv_ptn = re.compile(r".*<p>Security Advisory:([^<]+)</p>.*", re.IGNORECASE)
    text = ""
    for line in lines:
        res = adv_ptn.match(line)
        if res:
            text = re.sub(adv_ptn, "\\1", line)
            break
    return text.strip()

def get_description(lines):
    u"""Descriptionを取得する"""

    desc_ptn    = re.compile(r".*<h2>Description</h2>", re.IGNORECASE)
    sol_ptn     = re.compile(r".*<h2>Solution</h2>", re.IGNORECASE)
    rep_br_ptn  = re.compile(r"<br\s*/>", re.IGNORECASE)
    rep_tag_ptn = re.compile(r"</?[^>]+>", re.IGNORECASE)

    search_flg = False
    results = []
    for line in lines:
        if desc_ptn.match(line):
            search_flg = True

        if search_flg:
            results.append(line)
            if sol_ptn.match(line):
                break

    text = results[1:-2][0]
    text = rep_br_ptn.sub("", text)
    return rep_tag_ptn.sub("", text).strip()

def get_dates(lines):
    ptn = re.compile(r".*<dd>([^<]+)</dd>", re.IGNORECASE)

    # ddタグで囲われているのは日付の２つのみなのでbreakなし
    search_flg = False
    results = []
    for line in lines:
        if ptn.match(line):
            line = re.sub(ptn, "\\1", line)
            results.append(line)
    
    return results[0], results[1]

if __name__ == '__main__':
    main()
