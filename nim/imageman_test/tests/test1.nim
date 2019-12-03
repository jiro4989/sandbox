import unittest

import os
import imageman

const
  testDir = "tests"
  imageFile = testDir / "sample.png"

test "loadImage":
  discard loadImage[ColorRGBU](imageFile)

test "resizedBicubic":
  let img = loadImage[ColorRGBU](imageFile)
  let img2 = img.resizedBicubic(512, 512)
  img2.savePNG(testDir / "bicubic.png")

