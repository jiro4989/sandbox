import imageman

block:
  let img = loadImage[ColorRGBU]("sample.png")

  block:
    # 水平反転
    let img2 = img.flippedHoriz()
    img2.savePNG("out_flip_horiz.png")

  block:
    # 垂直反転
    let img2 = img.flippedVert()
    img2.savePNG("out_flip_vert.png")

  block:
    # バイキュービック補間で拡大
    let img2 = img.resizedBicubic(512, 512)
    img2.savePNG("out_resize_bicubic.png")

  block:
    # トリミング
    let img2 = img.copyRegion(10, 10, 60, 20)
    img2.savePNG("out_copy_region.png")

block:
  var img = loadImage[ColorRGBU]("sample.png")
  let img2 = loadImage[ColorRGBU]("sample2.png")
  img.blit(img2, 0, 0)
  img.savePNG("out_blit.png")

block:
  var img = loadImage[ColorRGBAU]("sample.png")
  let img2 = loadImage[ColorRGBAU]("sample2.png")
  img.blit(img2, 0, 0)
  img.savePNG("out_blit_rgbau.png")

block:
  var img = loadImage[ColorRGBF]("sample.png")
  let img2 = loadImage[ColorRGBF]("sample2.png")
  img.blit(img2, 0, 0)
  img.savePNG("out_blit_rgbf.png")
