#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u'改行コードをCRLFからLFに変換する'

import os, argparse

def crlf2lf(target_dir):
    u'''\
    引数で指定したディレクトリ配下のすべてのファイルを対象に
    改行コードをCRLFからLFに変換する。

    @param target_dir 対象ディレクトリ文字列
    '''

    # サブディレクトリまでファイルとサブディレクトリ一覧取得。
    for path, subdirs, files in os.walk(target_dir):
        # 取得したファイル分のループ。
        for one_file in files:
            # ファイル読み込み。「rb」指定がポイント。
            target_file = os.path.join(path, one_file)
            print(u'read: {target_file}')
            with open(target_file) as in_file:
                # バイナリなので行の概念が無い。
                file_data = in_file.read()

            # 文字置き換え。改行以外でも使える。これまた「b」指定がポイント。
            file_data = file_data.replace(b'\r\n', b'\n')

            # ファイル出力。これも「wb」指定がポイント。
            with open(target_file) as out_file:
                out_file.write(file_data)

def _get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
            'target_dir'
            , type=str
            , help=u'対象ディレクトリ。'
            )
    return parser.parse_args()

if __name__ == '__main__':
    args = _get_args()
    crlf2lf(args.target_dir)
