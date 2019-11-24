import os, strutils
import bigints # nimble install bigints

proc fib(m: int): BigInt =
  var x = initBigInt(0)
  var y = initBigInt(1)
  for i in 1..<m:
    (x, y) = (y, x+y)
  return y

let args = commandLineParams()
let m = args[0].parseInt
echo fib(m)
