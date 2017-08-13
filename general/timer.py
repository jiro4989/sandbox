#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from sys import stdout
from datetime import datetime, timedelta
import time
import subprocess

"""
ダブルクリックで動きます。
"""

def open_browser(url):
    app = """C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"""
    subprocess.call("""{app} {url}""".format(app=app, url=url))

def main():
    first_time = datetime.now()
    time1 = first_time + timedelta(hours=1)
    time2 = first_time + timedelta(hours=2)

    while True:
        now = datetime.now()
        diff = time1 - now
        s = diff.total_seconds()
        stdout.write("\r" + str(s))
        if s <= 0:
            break
        time.sleep(1)

if __name__ == '__main__':
    main()
