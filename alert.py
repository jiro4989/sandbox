import datetime, time, ctypes

########################
# タイマーの時刻記入場所
# ex: time=hh:mm
#time=21:09
########################

MB_ICONINFORMATION = 0x40
MB_ABORTRETRYIGNORE = 2
MB_TASKMODAL = 0x2000
style = MB_ICONINFORMATION | MB_ABORTRETRYIGNORE | MB_TASKMODAL

def msgbox():
	ctypes.windll.user32.MessageBoxW(0, u"時間です！", "alert.py",
			MB_TASKMODAL)

def check_time(alerttime, action=None):
	while True:
		now = datetime.datetime.now().strftime("%H:%M")
		print("\r" + now)
		if now == alerttime:
			if action != None:
				action()
			break
		time.sleep(3)

def main():
	lines = open("alert.py", encoding="utf-8").read().split("\n")
	times = [l.split("=")[1] for l in lines if l.startswith("#time=")]
	for time in times:
		check_time(time, msgbox)

if __name__ == '__main__':
	main()
