# coding: utf-8

import os
import sys
from os.path import dirname, abspath
from os import sep

def fild_all_files(directory):
    for root, dirs, files in os.walk(directory):
        yield root
        for file in files:
            yield os.path.join(root, file)

def main():
    directory = None
    if len(sys.argv) < 2:
        print(u'対象ディレクトリを選択してください。')
        sys.stdout.write('>> ')
        directory = input()
        if not os.path.exists(directory):
            print("{dir} doesn't exist.".format(dir=directory))
            sys.exit()
    else:
        directory = sys.argv[1]

    total = 0

    cd = dirname(abspath(__file__))
    for file in fild_all_files(directory):
        path = cd + sep + file
        if os.path.isfile(path):
            count = sum(1 for line in open(path, 'r', encoding='utf-8'))
            print(file, count)
            total += count
    print()
    print('total = ' + str(total))

if __name__ == '__main__':
    main()

