# -*- coding: utf-8 -*-

import twython
import configparser
import re
from sys import stdout

cfgfile = configparser.ConfigParser()
cfgfile.read('.config')

user_id        = cfgfile.get('oauth', 'user_id')
consumerKey    = cfgfile.get('oauth', 'app_key')
consumerSecret = cfgfile.get('oauth', 'app_secret')
accessToken    = cfgfile.get('oauth', 'oauth_token')
accessSecret   = cfgfile.get('oauth', 'oauth_token_secret')

api = twython.Twython(app_key=consumerKey,
		app_secret=consumerSecret,
		oauth_token=accessToken,
		oauth_token_secret=accessSecret)

def print_menu():
	print(u"""
::: keybotter :::

t tw : tweets | h : home | q : quit
""")

def print_home():
	timeline = api.get_home_timeline(count=10)
	timeline.reverse()
	for json in timeline:
		user = json['user']
		name = user['name']
		tweets = json['text']
		print('%s - %s' % (name, tweets))

def tweets(keyinput):
	tweets = re.split(r'\s', keyinput)
	tw = ' '.join(tweets[1:])
	try:
		api.update_status(status=tw)
	except twython.TwythonError as e:
		print(e)

def main():
	while True:
		print_menu()
		stdout.write('input >> ')
		keyinput = input()

		if keyinput == 'q':
			break
		elif keyinput.startswith('t '):
			tweets(keyinput)
			print_home()
		elif keyinput == 'h':
			print_home()
		else:
			print(u'キー入力が誤っています。')

if __name__ == '__main__':
	main()
