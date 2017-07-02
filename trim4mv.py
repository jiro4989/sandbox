#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from PIL import Image
import os, sys, argparse, re
from os.path import join, isdir, dirname, abspath, exists
import tkinter as tk

u'''指定のディレクトリ内のすべての画像ファイルをツクールMV用にトリミングする。'''

# ツクールMVの１タイルあたりの解像度
W = 144
cdnate_filename = None

def main():
    global cdnate_filename
    args = get_args()
    p = dirname(abspath(args.target_dir)) if args.out_dir == None \
            else abspath(args.out_dir)
    cdnate_filename = join(p, 'coordinates.csv')

    COLOR = 'RGBA'

    # 画像タイルにまとめる対象画像の取得
    files = os.listdir(args.target_dir)
    files = [join(args.target_dir, f) for f in files if not isdir(f)]

    # 座標を指定するファイルが存在しない場合は、
    # 座標ファイルを生成するためにGUIを表示
    if not exists(cdnate_filename):
        img = Image.open(files[0]).convert(COLOR)
        show_gui(img)

    with open(cdnate_filename) as buff:
        # CSVファイルから座標を取得 [x,y]
        cdnate = buff.readlines()[0].split(',')

        # 画像タイルとして出力するためのImageを生成
        tile_screen = (W * 4, W * 2)
        tile_img = Image.new(COLOR, tile_screen)

        # 拡大縮小スケール値
        scale = int(cdnate[0])

        # トリミングする解像度
        res = resolution(int(cdnate[1]), int(cdnate[2]))

        # 出力するタイル画像に割り振るインデックス
        fileindex = 1

        # ファイル名連番の３桁目の番号を格納する
        topnum = 0

        # 取得していた画像ファイルすべてを処理
        for f in files:
            print(f'{f} の貼り付け ')

            # ファイルの連番を取得
            filenum = re.findall('(\d+)', os.path.basename(f))[1]
            filenum = int(filenum)

            # 連番の3桁目の値が変化していたら
            # （オプションの画像を処理し始めたら）
            if topnum < filenum // 100:
                print(u'出力ファイル先の切り替え')
                save(p, args.out_formatter, fileindex, tile_img)
                # 新しい画像を生成して、番号を更新
                tile_img = Image.new(COLOR, tile_screen)
                fileindex += 100
                fileindex = fileindex // 100 * 100 + 1
                topnum = filenum // 100

            img = Image.open(f).convert(COLOR)
            size = calc_scale(img, scale)
            resized_img = img.resize(size, Image.BICUBIC)
            cimg = resized_img.crop(res)

            # 8枚をオーバーしたら一度保存してタイル画像を初期化
            i = (filenum - 1) % 100
            if i % 8 == 0 and i != 0:
                save(p, args.out_formatter, fileindex, tile_img)
                fileindex += 1
                tile_img = Image.new(COLOR, tile_screen)
            tile_img.paste(cimg, calcpos(i), cimg.split()[3])

        save(p, args.out_formatter, fileindex, tile_img)

def save(p, formatter, fileindex, tile_img):
    outname = join(p, f'{formatter}.png' % fileindex)
    sys.stdout.write(f'Save {outname} >>> ')
    try:
        tile_img.save(outname)
        print(u'成功！')
    except:
        print(u'失敗！')

def calcpos(i):
    y, x = divmod(i, 4)
    x *= W
    y *= W
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

    parser.add_argument(
            'out_formatter'
            , type=str
            , help=u'出力するファイル名書式'
            )

    parser.add_argument(
            '-o'
            , '--out-dir'
            , type=str
            , help=u'画像の出力先ディレクトリ'
            , default=None
            )

    args = parser.parse_args()
    return args

def resolution(x, y):
    return (x, y, x+W, y+W)

def calc_scale(img, scale):
    rate = scale / 100
    w, h = img.size
    w *= rate
    h *= rate
    size = (int(w), int(h))
    return size

def show_img(img, scale, x, y):
    print(f'scale: {scale}, x: {x}, y: {y}')
    size = calc_scale(img, scale)
    resized_img = img.resize(size, Image.BICUBIC)
    cropped_img = resized_img.crop(resolution(x, y))
    cropped_img.show()

def quit(root, scale, x, y):
    global cdnate_filename
    with open(cdnate_filename, 'w') as f:
        f.write(f'{scale},{x},{y}')
    root.quit()

def show_gui(img):
    imgsize = img.size
    root = tk.Tk()

    img_max_width  = imgsize[0] - W
    img_max_height = imgsize[1] - W

    scale_var = tk.IntVar()
    scale_var.set(100)

    ss = tk.Spinbox(root, from_=0, to=200, increment=5, width=10,
            textvariable=scale_var)
    xs = tk.Spinbox(root, from_=0, to=img_max_width, increment=5, width=10)
    ys = tk.Spinbox(root, from_=0, to=img_max_height, increment=5, width=10)

    # 更新処理を実行するためのボタン
    update_btn = tk.Button(root, text=u'確認'
            , command=lambda: show_img(img, int(scale_var.get()), int(xs.get()), int(ys.get())))
    finish_btn = tk.Button(root, text=u'終了'
            , command=lambda: quit(root, int(scale_var.get()), int(xs.get()), int(ys.get())))

    # 各種コンポーネントの配置
    ss.pack()
    xs.pack()
    ys.pack()
    update_btn.pack()
    finish_btn.pack()

    root.mainloop()

if __name__ == '__main__':
    main()

