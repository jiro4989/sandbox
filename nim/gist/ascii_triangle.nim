import unicode, sequtils, algorithm, strutils

func corner(text: string): seq[string] =
  var tmp = text.toRunes
  for i in 1..tmp.len:
    result.add $tmp[0..<i]

func maxLen(lines: seq[string]): int =
  let lens = lines.mapIt(it.toRunes.len)
  let zipped = zip(lens, lines)
  let max = zipped.sortedByIt(it[0])[^1][0]
  return max

func middle(lines: seq[string]): seq[string] =
  let max = lines.maxLen
  for line in lines:
    let padLen = (max - line.toRunes.len) div 2
    let pad = "　".repeat(padLen).join
    result.add pad & line

func right(lines: seq[string]): seq[string] =
  let max = lines.maxLen
  for line in lines:
    let padLen = (max - line.toRunes.len)
    let pad = "　".repeat(padLen).join
    result.add pad & line

const text = "新年あけましておめでとうございます"

for line in corner(text):
  echo line

for line in corner(text).middle:
  echo line

for line in corner(text).right:
  echo line

# $ nim c -r ascii_triangle.nim
#
# output:
#[
新
新年
新年あ
新年あけ
新年あけま
新年あけまし
新年あけまして
新年あけましてお
新年あけましておめ
新年あけましておめで
新年あけましておめでと
新年あけましておめでとう
新年あけましておめでとうご
新年あけましておめでとうござ
新年あけましておめでとうござい
新年あけましておめでとうございま
新年あけましておめでとうございます
　　　　　　　　新
　　　　　　　新年
　　　　　　　新年あ
　　　　　　新年あけ
　　　　　　新年あけま
　　　　　新年あけまし
　　　　　新年あけまして
　　　　新年あけましてお
　　　　新年あけましておめ
　　　新年あけましておめで
　　　新年あけましておめでと
　　新年あけましておめでとう
　　新年あけましておめでとうご
　新年あけましておめでとうござ
　新年あけましておめでとうござい
新年あけましておめでとうございま
新年あけましておめでとうございます
　　　　　　　　　　　　　　　　新
　　　　　　　　　　　　　　　新年
　　　　　　　　　　　　　　新年あ
　　　　　　　　　　　　　新年あけ
　　　　　　　　　　　　新年あけま
　　　　　　　　　　　新年あけまし
　　　　　　　　　　新年あけまして
　　　　　　　　　新年あけましてお
　　　　　　　　新年あけましておめ
　　　　　　　新年あけましておめで
　　　　　　新年あけましておめでと
　　　　　新年あけましておめでとう
　　　　新年あけましておめでとうご
　　　新年あけましておめでとうござ
　　新年あけましておめでとうござい
　新年あけましておめでとうございま
新年あけましておめでとうございます
]#
