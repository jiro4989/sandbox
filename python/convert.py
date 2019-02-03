import os, sys, re

def convert(text):
	sss = re.sub(r'(tanaka).*(dead)', r'\1 " + FINAL_VAR + " \2', target)
	print(sss)

u"""\
指定したフォルダ内に存在するすべての
ディレクトリとファイルを返す。
"""
def walktree(directory):
	for root, dirs, files in os.walk(directory):
		yield root
		for file in files:
			yield os.path.join(root, file)

if __name__ == '__main__':
	args = sys.argv
	if len(args) < 2:
		print(u"フォルダの指定が必須です。 = args[1]")
		sys.exit()

	# 対象フォルダ内のすべてのファイルを取得する
	# 取得する対象は以下の条件で絞り込む
	# 1. ファイルである
	# 2. 拡張子はpyである
	allfiles = [file for file in walktree(args[1])\
			if os.path.isfile(file)\
			and str(file).endswith(".py")]

	# 重複するファイルを削除する
	distinct_files = list(set(allfiles))

	for file in distinct_files:
		lines = open(file, encoding="utf-8").readlines()
		for i, line in enumerate(lines):
			# for を含むのみを処理する
			if "for" in line:
				i = "%04d" % i
				sys.stdout.write(file + ": " + i + ": " + line)
				newline = ""
				if line.startswith('"for'):
					newline = line.replace('for', 'FOR + ')
				elif line.endswith('for"'):
					newline = line.replace('for', ' + FOR')
				else:
					newline = line.replace('for', ' + FOR + ')
				sys.stdout.write(file + ": " + i + ": " + newline)

		#for line in [line for line in lines if "for" in line]:
		#	sys.stdout.write(line)

