#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u'改行コードを変換する'

import os, argparse

def walktree(directory):
    u'''\
    指定したディレクトリ配下のすべてのファイルとディレクトリを返す。
    '''
    for root, dirs, files in os.walk(directory):
        yield root
        for file in files:
            yield os.path.join(root, file)

def convert(target_file, fromlf, tolf):
    u'''\
    指定のディレクトリを指定の改行コードから改行コードに変換する。
    '''
    print(u'read: {target_file}')
    with open(target_file, 'rb') as in_file:
        file_data = in_file.read()

    file_data = file_data.replace(fromlf, tolf)

    with open(target_file, 'wb') as out_file:
        out_file.write(file_data)

def swlf(lf):
    u'''\
    改行文字をpython内で使用するバイナリ型特殊文字としての改行文字に変換する。
    '''
    if lf == '''\r\n''':
        return b'\r\n'
    elif lf == '''\r''':
        return b'\r'
    else:
        return b'\n'

def _get_args():
    parser = argparse.ArgumentParser()

    parser.add_argument( 'target_dir' , type=str , help=u'対象ディレクトリ。')
    parser.add_argument( 'fromlf'     , type=str , help=u'置換対象改行コード')
    parser.add_argument( 'tolf'       , type=str , help=u'置換後改行コード')

    return parser.parse_args()

if __name__ == '__main__':
    args = _get_args()

    files  = walktree(args.target_dir)
    fromlf = swlf(args.fromlf)
    tolf   = swlf(args.tolf)

    for f in [f for f in files if os.path.isfile(f)]:
        convert(f, fromlf, tolf)
