#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, time
from datetime import datetime

def main():
    starttime = datetime.now()
    print(u"計測開始 : " + starttime.strftime("%H:%M:%S"))
    while True:
        now = datetime.now()
        diff = now - starttime
        sys.stdout.write(u"経過時間 : " + calctime(diff.seconds) + "\r")
        time.sleep(0.5)

def calctime(seconds):
    hours  , seconds = divmod(seconds, 60 * 60)
    minutes, seconds = divmod(seconds, 60)
    timetext = "%02d:%02d:%02d" % (hours, minutes, seconds)
    return timetext

if __name__ == '__main__':
    main()

