#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from PIL import Image
import os, sys, argparse
from os.path import join, isdir, dirname, abspath
import tkinter as tk

u'''指定のディレクトリ内のすべての画像ファイルをツクールMV用にトリミングする。'''

# ツクールMVの１タイルあたりの解像度
W = 144
# コマンドライン引数
args = None
cdnate_filename = None

def main():
    args = get_args()
    p = abspath(args.target_dir)
    p = dirname(p)
    cdnate_filename = join(p, 'coordinates.csv')

    COLOR = 'RGBA'

    # 画像タイルにまとめる対象画像の取得
    files = os.listdir(args.target_dir)
    files = [join(args.target_dir, f) for f in files if not isdir(f)]

    # 座標を指定するファイルが存在しない場合は、
    # 座標ファイルを生成するためにGUIを表示
    if not os.path.exists(cdnate_filename):
        img = Image.open(files[0]).convert(COLOR)
        show_gui(img)

    with open(cdnate_filename) as buff:
        # CSVファイルから座標を取得 [x,y]
        cdnate = buff.readlines()[0].split(',')

        # 画像タイルとして出力するためのImageを生成
        tile_screen = (W * 4, W * 2)
        tile_img = Image.new(COLOR, tile_screen)

        # トリミングする解像度
        res = resolution(cdnate[0], cdnate[1])

        # 出力するタイル画像に割り振るインデックス
        fileindex = 1
        for i, f in enumerate(files):
            img = Image.open(f).convert(COLOR)
            cimg = img.crop(res)
            # 8枚をオーバーしたら一度保存してタイル画像を初期化
            if i % 8 == 0:
                tile_img.save(join(p, 'tile%03d.png' % fileindex))
                fileindex += 1
                tile_img = Image.new(COLOR, tile_screen)
            tile_img.paste(cimg, calcpos(i), cimg.split()[3])
        tile_img.save(join(p, 'tile%03d.png' % fileindex))

def calcpos(i):
    x = i % 4 * W
    y = i // 4 * w

    if 0 < i // 8:
        y -= i // 8 * 2 * W

    return (x, y)

def get_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
            'target_dir'
            , type=str
            , help=u'トリミング対象のディレクトリ'
            )

    args = parser.parse_args()
    return args

def resolution(x, y):
    return (x, y, x+W, y+W)

def show_img(img, x, y):
    print(f'x: {x}, y: {y}')
    cropped_img = img.crop(resolution(x, y))
    cropped_img.show()

def quit(root, x, y):
    with open(cdnate_filename) as f:
        f.write(f'{x},{y}')
    root.quit()

def show_gui(img):
    imgsize = img.size
    root = tk.Tk()

    img_max_width  = imgsize[0] - W
    img_max_height = imgsize[1] - W

    xs = tk.Spinbox(root, from_=0, to=img_max_width, increment=1, width=10)
    ys = tk.Spinbox(root, from_=0, to=img_max_height, increment=1, width=10)

    # 更新処理を実行するためのボタン
    update_btn = tk.Button(root, text=u'確認', command=lambda: show_img(img,
        int(xs.get()), int(ys.get())))
    finish_btn = tk.Button(root, text=u'終了', command=lambda: quit(root,
        int(xs.get()), int(ys.get())))

    # 各種コンポーネントの配置
    xs.pack()
    ys.pack()
    update_btn.pack()
    finish_btn.pack()

    root.mainloop()

if __name__ == '__main__':
    main()

