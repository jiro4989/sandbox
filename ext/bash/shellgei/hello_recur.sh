#!/bin/bash

# ネタシェル芸
# 再帰的HelloWorld出力

recur() {
  if [ "$1" = "H" ]; then
    printf "$1"
    return
  fi
  local v=$1
  shift
  recur ${@}
  printf "$v"
}

recur d l r o W o l l e H

