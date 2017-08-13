# coding: utf-8

u"""
画像左右反転スクリプト。

スクリプトの実行ディレクトリに存在する
right フォルダ内のすべてのpngファイルを左右反転し、
left  フォルダに出力する。

この時、leftフォルダが存在しなかった場合は自動で生成される。
ファイルの内、画像の向きを表す _R_ という文字列を
自動で _L_ に変換して出力する。

"""

from PIL import Image

from glob import glob
from os import sep
from os.path import join, relpath
import os, re, sys

def main():
    if len(sys.argv) < 2:
        print(u'引数が必要です。 target right dir')
        sys.exit()

    d = sys.argv[1]
    rdir = os.path.join(d, 'right')
    ldir = os.path.join(d, 'left')

    if not os.path.exists(rdir):
        print('rightディレクトリを作成しました。')
        os.mkdir(rdir)

    if not os.path.exists(ldir):
        print('leftディレクトリを作成しました。')
        os.mkdir(ldir)

    rfiles    = [x for x in glob(join(rdir, '*.png'))]
    filenames = [relpath(x, rdir) for x in rfiles]

    for (rfile, filename) in zip(rfiles, filenames):
        rimg = Image.open(rfile)
        limg = rimg.transpose(Image.FLIP_LEFT_RIGHT)
        filename = filename.replace('_R_', '_L_')
        lname = os.path.join(ldir, filename)
        limg.save(lname)
        print('[ {0} ] を出力しました。'.format(lname))

    print('正常に出力が完了しました！')

if __name__ == '__main__':
    main()
