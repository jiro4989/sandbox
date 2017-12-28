# 今月のカレンダーをprint

import calendar as cal
from datetime import datetime as dt

t = dt.today()
y, m = t.year, t.month
html = cal.HTMLCalendar().formatmonth(y, m)
print(html)
