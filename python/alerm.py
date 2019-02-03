#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, time, argparse, os
from datetime import datetime, timedelta

def main():
    args = _get_args()
    h,m  = args.timestr.split(":")

    # now = datetime.now()
    # y, m, d = now.year, now.month, now.day
    # endtime = datetime(y, m, d, h, m)
    # print(endtime)

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
    os.system("start cmd /t:E0")

def calctime(seconds):
    hours  , seconds = divmod(seconds, 60 * 60)
    minutes, seconds = divmod(seconds, 60)

    timetext = "%02d:%02d:%02d" % (hours, minutes, seconds)
    return timetext

def _get_args():
    parser = argparse.ArgumentParser(description=u'残り時間を表示する。')

    parser.add_argument(
            'timestr'
            , type=str
            , help=u'時間の指定'
                    )

    return parser.parse_args()

if __name__ == '__main__':
    main()

