import feedparser
from sys import stdout

urls = open('input/rss.txt').readlines()

feeds = [feedparser.parse(x) for x in urls]

for i in range(len(feeds)):
	feed  = feeds[i]
	title = feed.feed.title
	print('[{0:02d}] - {title}'.format(i, title=title))

stdout.write('index >> ')
index = input()
index = int(index)

for entry in feeds[index].entries:
	title = entry.title
	link  = entry.link
	print(link)
	print(title)

