from sys import stdout
from datetime import datetime, timedelta
import time
import subprocess

########################
# タイマーの時刻記入場所
# ex: time=hh:mm;action
#time=11:11;https://www.google.co.jp/
#time=11:12;
########################

def open_browser(url):
    app = """C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"""
    subprocess.call("""{app} {url}""".format(app=app, url=url))

def check_time(alerttime):
    while True:
        now = datetime.datetime.now()
        tmpalert = alerttime.split(";")
        at = convert_time(tmpalert[0])
        diff = at - now
        st = str(diff)
        print(st[:st.index(".")])
        if diff.seconds <= 0:
            # 画面通知の商事
            subprocess.call("powershell popup.ps1")
            # 表示のアクションがアレば実行
            if 1 < len(tmpalert):
                if tmpalert[1].startswith("http"):
                    open_browser(tmpalert[1])
            break
        time.sleep(1)

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

    print(nexttime - now)
    #lines = open("pytimer.py", encoding="utf-8").read().split("\n")
    #times = [l.split("=")[1] for l in lines if l.startswith("#time=")]
    #for time in times:
    #    check_time(time)

if __name__ == '__main__':
    main()
