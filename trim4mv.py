#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from PIL import Image
import os, sys, argparse
from os.path import join, isdir
from tkinter import *

u'''指定のディレクトリ内のすべての画像ファイルをツクールMV用にトリミングする。'''

W = 144

def main():
    args = get_args()
    # ツクールMVの画像タイルの規格は144x144
    # よって、4x2のタイルの解像度は 576x288
    COLOR = 'RGBA'

    # 画像タイルにまとめる対象画像の取得
    files = os.listdir(args.target_dir)
    files = [join(args.target_dir, f) for f in files if not isdir(f)]

    # 画像タイルとして出力するためのImageを生成
    tile_screen = (W * 4, W * 2)
    tile_img = Image.new(COLOR, tile_screen)

    img = Image.open(files[0]).convert(COLOR)
    cropped_img = img.crop((100, 1000, 100+W, 1000+W))
    cropped_img.show()

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
            'target_dir'
            , type=str
            , help=u'トリミング対象のディレクトリ'
            )
    args = parser.parse_args()
    return args

def update_img():
    print('update')

def show_gui(imgsize):
    root = Tk()

    img_max_width = imgsize[0] - W
    img_max_height = imgsize[1]l - W

    # 座標を決めるスケール
    x = IntVar().set(0)
    y = IntVar().set(0)
    xs = Scale(root, label='x', orient='h', from_=0, to=img_max_width,
            variable=x)
    ys = Scale(root, label='y', orient='h', from_=0, to=img_max_height,
            variable=y)

    # 更新処理を実行するためのボタン
    update_btn = Button(root, text=u'更新', command=update_img)
    finish_btn = Button(root, text=u'終了')

    # 各種コンポーネントの配置
    xs.pack()
    ys.pack()
    update_btn.pack()
    finish_btn.pack()

    root.mainloop()

if __name__ == '__main__':
    sys.exit()
    main()

