# coding: utf-8

u"""

タイマースクリプト。
タイマーテキストファイルの時間と音声ファイルの情報から
自動で次のタイマーをセットし、指定の時間に音楽を鳴らす。

読み込むタイマーテキストファイルの書式はcsvをベースにしている。
書式は下記のとおり.

------

# comment (ignore)
mm:ss,wavfile,date

------

::: 注意点 :::

1. 時間の書式はmm:ssで、カンマや数値の間に空白の混入を認めない。
2. インラインコメントは不可

特殊な機能として、特定の曜日にのみタイマーを鳴らせる。
タイマー実行時の曜日と、テキストデータの中に存在する曜日が一致するもののみ、鳴ら
す。

曜日の一覧は以下の通り

['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Son', 'Evr']

"""

import pyaudio
import wave

from datetime import datetime
from sys import stdout
from time import sleep
import re
import sys
import time

u"""
引数のチェック
引数の一つ目は音を鳴らすタイミングと音声ファイルを記述したテキストファイル
"""
if len(sys.argv) < 2:
	print(u'コマンドライン引数が不足しています。')
	print(u'args[1] = time.csv')
	for (i,a) in enumerate(sys.argv):
		print(str(i) + ' - ' + a)
	exit()

CHUNK = 1024
WEEKS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Son', 'Evr']

u"""
渡されたwavファイルを鳴らす
@param filename wavfile
"""
def play_music(filename):
	filename = './audio/lu.wav'
	wf = wave.open(filename, 'rb')

	p = pyaudio.PyAudio()
	stream = p.open(format=p.get_format_from_width(wf.getsampwidth()),
			channels=wf.getnchannels(),
			rate=wf.getframerate(),
			output=True)

	# 1024個読み取り
	data = wf.readframes(CHUNK)

	while len(data) != 0:
		stream.write(data)          # ストリームへの書き込み(バイナリ)
		data = wf.readframes(CHUNK) # ファイルから1024個*2個の

	stream.stop_stream()
	stream.close()

	p.terminate()

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
red    = getcolor('red')
yellow = getcolor('yellow')
green  = getcolor('green')

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

weekindex = datetime.today().weekday()
week = WEEKS[weekindex]

# csvファイルからタイマーのタイミングを読み込み
# 毎日、あるいは今日の曜日のデータが存在するもののみをフィルタリング
timelines = open(sys.argv[1], 'r').readlines()
timelines = [l for l in timelines if not l.startswith('#')]
timelines = [l for l in timelines if not re.match('^$', l)]
timelines = [l for l in timelines if l.split(',')[2].rfind(WEEKS[-1]) != -1 \
		or l.split(',')[2].rfind(week) != -1]
csv = [l.split(',') for l in timelines]

# 時刻を取得
timeline = csv[0][0]
tl = timeline.split(':')
(h, m) = int2(tl)
nexttime = mktime(h,m)

# 時刻リストの末尾に到達するまでループ
count = 0
while True:
	nowtime = datetime.today()
	nowtime = nowtime.timetuple()
	nowtime = time.mktime(nowtime)

	# hh:mm:ssの取得
	diff   = nexttime - nowtime
	hour   = int(  diff / HOUR)
	minute = int(( diff % HOUR) / MINUTE)
	second = int(((diff % HOUR) % MINUTE))

	# 色を変更して残り時間を標準出力
	text = mk_time_text(hour, minute, second)
	stdout.write(text)

	if (hour <= 0 and minute <= 0 and second <= 0) or (hour < 0):
		count += 1

		if len(timelines) <= count:
			break

		current = csv[count]
		(h, m) = int2(current[0].split(':'))
		nexttime = mktime(h,m)
		play_music(csv[count][1])

	sleep(1)

print(u"""
本日の業務は終了です。
お疲れ様でした。
また明日も頑張りましょう！
""")
