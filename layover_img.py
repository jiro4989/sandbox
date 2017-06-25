#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from PIL import Image
from image4layer import Image4Layer
import os, sys, time, json

def main():
    infofile = open('./img/image_layer.json')
    info = json.load(infofile)

    imgdir = info["imgdir"]
    outdir = info["outdir"]

    if not (os.path.exists(imgdir)):
        print(imgdir +  'が存在しません。')
        time.sleep(1)
        sys.exit()

    mk_outdir(outdir)

    imginfo    = info['img']
    outname    = imginfo['outname']
    ext        = imginfo['ext']
    colormodel = imginfo['colormodel']
    base       = imginfo['base']
    pattern    = imginfo['pattern']
    baseimg    = Image.open(f'{imgdir}/{base}.{ext}').convert(colormodel)

    for opt in imginfo['option']:
        # 必須の8画像を出力
        for i, necessary in enumerate(pattern['necessary']):
            i += 1

            eyebrows = necessary['eyebrows']
            eye      = necessary['eye']
            mouse    = necessary['mouse']

            processing_image(i, outname, outdir, imgdir, ext, opt, baseimg, eyebrows, eye, mouse)

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
                        processing_image(i, outname, outdir, imgdir, ext, opt, baseimg, eyebrows, eye, mouse)

    print('スクリプトは正常に終了しました。')

def processing_image(i, outname, outdir, imgdir, ext, opt, baseimg, eyebrows, eye, mouse):
    u'''\
    画像を加工する。
    '''
    name = outname.format(i) if opt == None else outname.format(i+100)
    sys.stdout.write(f'{name} >>> ')
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
    sys.stdout.write('出力先ディレクトリの生成 >>> ')
    try:
        os.mkdir(path)
        print('成功！')
    except:
        print('失敗！ すでに存在します。')

if __name__ == '__main__':
    main()

