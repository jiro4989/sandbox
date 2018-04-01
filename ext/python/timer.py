#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, time, argparse, os
from datetime import datetime, timedelta

def main():
    args     = _get_args()
    timenum  = args.timenum
    timetype = args.timetype

    if timetype == "s":
        start(timenum)
    elif timetype == "m":
        start(timenum * 60)
    else:
        start(timenum * 60 * 60)

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
            'timenum'
            , type=int
            , help=u'計測する時間'
                    )

    parser.add_argument(
            '-t'
            , '--timetype'
            , type=str
            , default='m'
            , help=u'時間のタイプ (s|m|h) default: m'
                    )

    return parser.parse_args()

if __name__ == '__main__':
    main()

