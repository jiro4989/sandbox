#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, time
from datetime import datetime, timedelta

def main():
    args = sys.argv
    timenum  = int(args[1])

    if len(args) < 3:
        timetype = "m"
    else:
        timetype = args[2]

    if timetype == "s":
        start(timenum)
    elif timetype == "m":
        start(timenum * 60)
    else:
        start(timenum * 60 * 24)

def start(timenum):
    print(u"計測時間 : " + calctime(timenum))
    now = datetime.now()
    endtime = now + timedelta(seconds=timenum)
    while True:
        now = datetime.now()
        diff = endtime - now
        sys.stdout.write(u"残り時間 : " + calctime(diff.seconds) + "\r")
        time.sleep(0.5)
        if diff.seconds <= 0:
            print()
            break
    print("Time Up")

def calctime(seconds):
    hours  , seconds = divmod(seconds, 60 * 24)
    minutes, seconds = divmod(seconds, 60)

    timetext = "%02d:%02d:%02d" % (hours, minutes, seconds)
    return timetext

if __name__ == '__main__':
    main()

