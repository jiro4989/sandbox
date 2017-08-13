#!/usr/bin/env python3
# -*- coding: utf-8 -*-

u'''差分画像を指定のパターンで組み合わせて出力する'''

from PIL import Image
from image4layer import Image4Layer
import os, sys, time, json
import argparse

def main():
    parser = argparse.ArgumentParser(description=\
            u'これはパーツ画像ファイルから立ち絵差分を生成するスクリプトです。')

    parser.add_argument(
            'path_img_layer'
            , type=str
            , help=u'処理する画像のパターンを指定するファイル (json)'
            )

    parser.add_argument(
            'out_formatter'
            , type=str
            , help=u'出力ファイル名の書式。(ex: out%03d (拡張子不要))'
            )

    parser.add_argument(
            '-s'
            , '--src-dir'
            , type=str
            , help=\
                    u'画像生成元の画像パターンが存在するディレクトリ。'
                    u'default : image_layer.jsonと同じ階層のsrcディレクトリ'
            , default='src'
                    )

    parser.add_argument(
            '-o'
            , '--out-dir'
            , type=str
            , help=\
                    u'パターンから生成された画像の出力先ディレクトリ。'
                    u'default : image_layer.jsonと同じ階層のoutディレクトリ'
            , default='out'
                    )

    args = parser.parse_args()

    infofile = open(args.path_img_layer)
    info = json.load(infofile)

    absimg = os.path.abspath(args.path_img_layer)
    imgdir = os.path.join(os.path.dirname(absimg), args.src_dir)
    outdir = os.path.abspath(args.out_dir)

    if not (os.path.exists(imgdir)):
        print(imgdir +  'が存在しません。')
        time.sleep(1)
        sys.exit()

    mk_outdir(outdir)

    imginfo       = info['img']
    out_formatter = args.out_formatter
    ext           = imginfo['ext']
    colormodel    = imginfo['colormodel']
    base          = imginfo['base']
    pattern       = imginfo['pattern']
    baseimg       = Image.open(f'{imgdir}/{base}.{ext}').convert(colormodel)

    for opt in imginfo['option']:
        # 必須の8画像を出力
        for i, necessary in enumerate(pattern['necessary']):
            i += 1

            eyebrows = necessary['eyebrows']
            eye      = necessary['eye']
            mouse    = necessary['mouse']

            processing_image(i, out_formatter, outdir, imgdir, ext, opt, baseimg, eyebrows, eye, mouse)

        # 移行はオプションで存在する場合だけ実行される
        others = pattern['others']
        if others != None:
            i = 8
            for eyes in others['eye']:
                eye = eyes['name']
                for eyebrows in eyes['eyebrows']:
                    for mouse in others['mouse']:
                        i += 1
                        baseimg  = Image.open(f'{imgdir}/{base}.{ext}').convert(colormodel)
                        processing_image(i, out_formatter, outdir, imgdir, ext, opt, baseimg, eyebrows, eye, mouse)

    print('スクリプトは正常に終了しました。')

def processing_image(i, out_formatter, outdir, imgdir, ext, opt, baseimg, eyebrows, eye, mouse):
    u'''\
    画像を加工する。
    '''
    name = out_formatter % i if opt == None else out_formatter % (i + 100)
    sys.stdout.write(f'{outdir}/{name}.{ext} >>> ')
    copyimg = baseimg.copy()

    try:
        if opt != None:
            i += 100
            copyimg = mul(      copyimg, f'{imgdir}/option/{opt[0]}.{ext}')
            copyimg = highlight(copyimg, f'{imgdir}/option/{opt[1]}.{ext}')

        layover_img(copyimg, f'{imgdir}/eyebrows/{eyebrows}.{ext}')
        layover_img(copyimg, f'{imgdir}/mouse/{mouse}.{ext}')
        layover_img(copyimg, f'{imgdir}/eye/{eye}.{ext}')

        copyimg.save(f'{outdir}/{name}.{ext}', 'PNG', quarity=100, optimize=True)
        print("出力成功！")
    except:
        print("出力失敗！")

def layover_img(srcimg, imgpath, color='RGBA'):
    u'''\
    元になる画像に画像を重ねる
    '''
    img = Image.open(imgpath).convert(color)
    srcimg.paste(img, (0,0), img.split()[3])

def mul(srcimg, imgpath, color='RGBA'):
    u'''\
    画像に乗算で画像を重ねて返す
    '''
    img = Image.open(imgpath).convert(color)
    return Image4Layer.multiply(srcimg, img)

def highlight(srcimg, imgpath, color='RGBA'):
    u'''\
    画像にlightenで画像を重ね返す
    '''
    img = Image.open(imgpath).convert(color)
    return Image4Layer.lighten(srcimg, img)

def mk_outdir(path):
    u'''\
    画像の出力先ディレクトリを生成する。
    '''
    sys.stdout.write(f'mkdir {path} >>> ')
    try:
        os.makedirs(path)
        print('成功！')
    except:
        print('失敗！ すでに存在します。')

if __name__ == '__main__':
    main()

