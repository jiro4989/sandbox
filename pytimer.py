import datetime, time
import subprocess

########################
# タイマーの時刻記入場所
# ex: time=hh:mm;action
#time=11:11;https://www.google.co.jp/
#time=11:12;
########################

first_time = datetime.datetime.now()
y, m, d = first_time.year, first_time.month, first_time.day

def convert_time(time):
    sp = [int(t) for t in time.split(":")]
    return datetime.datetime(y, m, d, sp[0], sp[1], 0, 0)

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
    lines = open("pytimer.py", encoding="utf-8").read().split("\n")
    times = [l.split("=")[1] for l in lines if l.startswith("#time=")]
    for time in times:
        check_time(time)

if __name__ == '__main__':
    main()
