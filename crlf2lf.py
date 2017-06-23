#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u'''指定したフォルダ内のすべてのファイルの改行コードのCRLFをLFに変換します。'''

import os, sys

def find_all_files(directory):
    u'''\
    指定したディレクトリ配下のすべてのファイルとディレクトリを返す。
    '''
    for root, dirs, files in os.walk(directory):
        yield root
        for file in files:
            yield os.path.join(root, file)

def crlf2lf(target_file, lf='\n'):
    u'''\
    渡された対象ファイルの改行文字を指定の改行文字に変換して書き込みます。

    デフォルトではLF(unix)に変換します。
    '''
    # テキストファイルからテキストを読み取り改行文字で区切る
    newlines = None
    with open(target_file, encoding='utf-8') as fromfile:
        newlines = fromfile.read().split('n')

    # 引数に指定された改行文字で、開いた時と同名のファイルに対して書き込む
    with open(target_file, 'w', encoding='utf-8', newline=lf) as tofile:
        tofile.writelines(newlines)

def os2lfcode(oscode):
    u'''\
    OS文字列を改行コードに変換します。

    oscode == dos -> \r\n
    oscode == mac -> \r
    else          -> \n
    '''
    if oscode == 'dos':
        return '\r\n'
    elif oscode == 'mac':
        return '\r'
    else:
        return '\n'

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(u'コマンドライン引数から対象ディレクトリを指定してください。')
        sys.exit()

    # 取得先フォルダを指定
    files = find_all_files(sys.argv[1])

    # ファイルのみを対象に操作する
    for target_file in [f for f in files if os.path.isfile(f)]:
        try:
            sys.stdout.write(f'{target_file:<30} | CRLF to LF ... ')

            lf = '\n' if len(sys.argv) < 3 else os2lfcode(sys.argv[2])
            crlf2lf(target_file, lf)

            print('Successed')
        except:
            print('Failed')

