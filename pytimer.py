# coding: utf-8

from datetime import datetime
from time import sleep
from sys import stdout
import time
import sys

if len(sys.argv) < 2:
	print(u'コマンドライン引数が不足しています。')
	print(u'args[1] = time.csv')
	for (i,a) in enumerate(sys.argv):
		print(str(i) + ' - ' + a)
	exit()

u"""
タイムミリ秒を返す関数
@param h 時間
@param m 分
"""
def mktime(h, m):
	date = datetime.today()
	t = datetime(date.year, date.month, date.day, h, m, 0)
	t = t.timetuple()
	t = time.mktime(t)
	return t

u"""
文字列配列を数値型タプルに変換して返却
"""
def int2(hm):
	return (int(hm[0]), int(hm[1]))

# 色文字列生成関数を返す
def getcolor(colorname):
	colors = {
			'clear'  : '\033[0m' ,
			'black'  : '\033[40m',
			'red'    : '\033[41m',
			'green'  : '\033[42m',
			'yellow' : '\033[43m',
			'blue'   : '\033[44m',
			'purple' : '\033[45m',
			'cyan'   : '\033[46m',
			'white'  : '\033[47m'
			}
	def f(c):
		return colors[colorname] + c + colors['clear']
	return f

# 色文字列生成関数
red   = getcolor('red')
yello = getcolor('yello')
green = getcolor('green')

# 各種時間に対応した時間文字列を生成する
def mk_time_text(hour, minute, second):
	text = '%02d:%02d:%02d\r' % (hour, minute, second)
	if hour <= 0 and minute <= 3:
		return red(text)
	elif hour <= 0 and minute <= 5:
		return yellow(text)
	else:
		return green(text)

# 時間定数
MINUTE = 60
HOUR   = 60 * MINUTE

# csvファイルからタイマーのタイミングを読み込み
timelines = open(sys.argv[1], 'r').readlines()
timelines = [l for l in timelines if not l.startswith('#')]
timelines = [l for l in timelines if l != '']

# 時刻を取得
timeline = timelines[0]
tl = timeline.split(':')
(h, m) = int2(tl)
nexttime = mktime(h,m)

# 時刻リストの末尾に到達するまでループ
count = 0
while True:
	if len(timelines) < count:
		break

	nowtime = datetime.today()
	nowtime = nowtime.timetuple()
	nowtime = time.mktime(nowtime)

	diff = nexttime - nowtime

	hour   = int(  diff / HOUR)
	minute = int(( diff % HOUR) / MINUTE)
	second = int(((diff % HOUR) % MINUTE))

	# 色を変更して残り時間を標準出力
	text = mk_time_text(hour, minute, second)
	stdout.write(text)

	if hour <= 0 and minute <= 0 and second <= 0:
		count += 1
		(h, m) = int2(timelines[count].split(':'))
		nexttime = mktime(h,m)

	sleep(1)

print(green(u"""
本日の業務は終了です。
お疲れ様でした。
また明日も頑張りましょう！
"""))
