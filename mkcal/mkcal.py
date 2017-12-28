#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u"""\
今月のカレンダーのHTMLを標準、またはファイルに出力する。

-d オプションを指定することで、任意の月を指定することができる。
-o オプションを使用してファイル名を指定するとHTMLファイルとして出力する

参考:
https://docs.python.jp/3/library/calendar.html
"""

import sys, argparse
import calendar as cal
from datetime import datetime as dt

# 曜日の番号にそれぞれクラスを割り当てる
#   0 == Monday
#   6 == Sonday
# calendarモジュールにもcalendar.MONDAYとかって定数が存在するが省略
# (実体はただのint)
DAY_MAP = {
          0 : {"text":u"月", "class":"mon"}
        , 1 : {"text":u"火", "class":"tue"}
        , 2 : {"text":u"水", "class":"wed"}
        , 3 : {"text":u"木", "class":"thu"}
        , 4 : {"text":u"金", "class":"fri"}

        , 5 : {"text":u"土", "class":"sat"}
        , 6 : {"text":u"日", "class":"sun"}
        }

def main(date, outfile):
    u"""\
    date 日付データ
    outfile 保存するファイル名
    """

    # HTML文字列を最後に連結するためのリスト
    tags  = []
    year  = date.year
    month = date.month

    tags.append("<table>\n")
    tags.append('  <caption>{year}/{month}</caption>\n'.format(year=year, month=month))

    # カレンダーのヘッダを追加
    tags.append("  <tr>\n")
    HEADER_FMT = '    <td class="calendar-header">{text}</td>\n'
    daytexts = [DAY_MAP[i]["text"] for i in [6, 0, 1, 2, 3, 4, 5]]
    header = [HEADER_FMT.format(text=d) for d in daytexts]
    tags.extend(header)
    tags.append("  </tr>\n")

    # 指定の月の週リストを取得
    # 週のはじめを日時曜に指定
    mdates = cal.Calendar(cal.SUNDAY).monthdatescalendar(year, month)

    # カレンダーの各種日付を追加
    for mdate in mdates:
        tags.append("  <tr>\n")
        for d in mdate:
            dayclass = DAY_MAP[d.weekday()]["class"]
            dayidx = d.day
            tag = '    <td class="{dayclass}">{dayidx}</td>\n'.format(
                    dayclass=dayclass
                    , dayidx=dayidx
                    )
            tags.append(tag)
        tags.append("  </tr>\n")
    tags.append("</table>\n")

    html = "".join(tags)

    # ファイル名の指定があればファイル出力
    # そうでなければ標準出力
    if outfile == None:
        print(html)
    else:
        # このソースファイルの末尾に存在する
        # "###"で始まる行を取得して結合し、HTMLテンプレートとして利用
        template = []
        with open(sys.argv[0]) as f:
            line = f.readline()
            while line:
                if line.startswith("###"):
                    template.append(line[3:])
                line = f.readline()
        template = "".join(template)

        with open(outfile, "w") as out:
            out.write(template.replace("{calendar}", html))

def _get_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
            "-d"
            , "--datestr"
            , type=str
            , help=u"指定する日付文字列 (%Y-%m-%d)"
            )

    parser.add_argument(
            "-o"
            , "--outfile"
            , type=str
            , help=u"ファイルに出力する場合のファイル名"
            )

    args = parser.parse_args()
    return args

if __name__ == '__main__':
    args = _get_args()

    # 引数に日付の指定がなければ追加
    date = args.datestr
    if date == None:
        date = dt.today()
    else:
        datefmts = [
                  "%Y-%m-%d"
                , "%Y-%m"
                , "%y-%m"
                , "%Y%m%d"
                , "%Y%m"
                , "%y%m"
                , u"%Y年%m月%d日"
                , u"%Y年%m月"
                , u"%y年%m月"
                ]
        for d in datefmts:
            try:
                date = dt.strptime(date, d)
                break
            except:
                pass

    main(date, args.outfile)

# ------------------------------------------------------------
# 力技すぎる...
# ------------------------------------------------------------
###<!DOCTYPE html>
###<html lang="ja">
###  <head>
###    <meta charset="UTF-8">
###    <title></title>
###    <style>
###
###table,tr,td {
###  border: 1px #000000 solid;
###}
###
###td {
###  text-align: right;
###}
###
###caption {
###  font-weight: bold;
###  font-style: italic;
###}
###
###.calendar-header {
###  font-weight: bold;
###  background-color: #87cefa;
###  text-align: center;
###}
###
###.sat, .sun {
###  background-color: orange;
###}
###
###    </style>
###  </head>
###  <body>
###   {calendar}
###  </body>
###</html>
