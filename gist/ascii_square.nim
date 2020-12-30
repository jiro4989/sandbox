import unicode, strutils, algorithm, sequtils

iterator corner(text: string): string =
  var tmp = text.toRunes
  for i in 0..tmp.len:
    var line = $tmp[0..^(i+1)] & "　"
    if i != 0:
      let ch = tmp[^i..^i][0]
      for i in 0..<i:
        line.add ch
    yield line

iterator square(text: string): string =
  for line in corner(text):
    echo line & line.toRunes.reversed.join
  for line in toSeq(corner(text)).reversed:
    echo line & line.toRunes.reversed.join

for line in square("こんにちは"):
  echo line

# $ nim c -r ascii_square.nim
#
# output:
#[
こんにちは　　はちにんこ
こんにち　はは　ちにんこ
こんに　ちちちち　にんこ
こん　にににににに　んこ
こ　んんんんんんんん　こ
　ここここここここここ　
　ここここここここここ　
こ　んんんんんんんん　こ
こん　にににににに　んこ
こんに　ちちちち　にんこ
こんにち　はは　ちにんこ
こんにちは　　はちにんこ
]#
