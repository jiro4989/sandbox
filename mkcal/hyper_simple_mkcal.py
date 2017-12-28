#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u"今月のカレンダーを標準出力"

import calendar as cal
from datetime import datetime as dt

DAY_MAP = {
          0 : {"text":u"月", "class":"mon"}
        , 1 : {"text":u"火", "class":"tue"}
        , 2 : {"text":u"水", "class":"wed"}
        , 3 : {"text":u"木", "class":"thu"}
        , 4 : {"text":u"金", "class":"fri"}

        , 5 : {"text":u"土", "class":"sat"}
        , 6 : {"text":u"日", "class":"sun"}
        }

date = dt.today()
year = date.year
month = date.month

tags = []
tags.append("<table>\n")
tags.append('<caption>{year}/{month}</caption>\n'.format(year=year, month=month))

# カレンダーのヘッダを追加
tags.append("<tr>\n")
HEADER_FMT = '<td class="calendar-header">{text}</td>\n'
daytexts = [DAY_MAP[i]["text"] for i in [6, 0, 1, 2, 3, 4, 5]]
header = [HEADER_FMT.format(text=d) for d in daytexts]
tags.extend(header)
tags.append("</tr>\n")

# 日曜日開始のカレンダーを生成
mdates = cal.Calendar(cal.SUNDAY).monthdatescalendar(year, month)
for mdate in mdates:
    tags.append("<tr>\n")
    for d in mdate:
        dayclass = DAY_MAP[d.weekday()]["class"]
        dayidx = d.day
        tag = '<td class="{dayclass}">{dayidx}</td>\n'.format(
                dayclass=dayclass
                , dayidx=dayidx
                )
        tags.append(tag)
    tags.append("</tr>\n")
tags.append("</table>\n")

print("".join(tags))

