#!/bin/bash

set -eu

(
  nim c -r main.nim
  nim c -d:num=9999 -r main.nim
  nim c -d:s=hello -r main.nim
  nim c -d:b=false -r main.nim
  nim c -d:num=255 -d:s=world -d:b=false -r main.nim
) | column -t
