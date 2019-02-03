#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, argparse
import zipfile, zlib

u'指定したフォルダをフォルダ名.zipという名前で保存する'

def main():
    print(u'pyzip.pyスクリプト開始')
    args = get_args()
    outname = f'{args.target_dir}.zip' if args.outname == None \
            else f'{args.outname}.zip'
    files = walktree(args.target_dir)

    with zipfile.ZipFile(outname, 'w', zipfile.ZIP_DEFLATED) as zf:
        for f in [x for x in files if not x.startswith(tuple(args.exclude))]:
            sys.stdout.write(f'ZIP {f:<30} >>> ')
            try:
                zf.write(str(f))
                print(u'成功！')
            except:
                print(u'失敗！')
    print(u'pyzip.pyスクリプトは正常に終了しました。')

def walktree(directory):
    u"""\
    指定したディレクトリ内に存在するすべての
    ディレクトリとファイルを返す。
    """
    for root, dirs, files in os.walk(directory):
        yield root
        for file in files:
            yield os.path.join(root, file)

def get_args():
    parser = argparse.ArgumentParser(description=\
            u'指定したフォルダ内のすべてのファイルを圧縮する')

    parser.add_argument(
            'target_dir'
            , type=str
            , help=\
                    u'圧縮対象ディレクトリ'
                    )

    parser.add_argument(
            '-n'
            , '--outname'
            , type=str
            , help=\
                    u'圧縮対象ディレクトリ'
                    )

    parser.add_argument(
            '-x'
            , '--exclude'
            , type=str
            , help=\
                    u'圧縮除外対象'
            , nargs='*'
                    )

    args = parser.parse_args()

    return args

if __name__ == '__main__':
    main()

