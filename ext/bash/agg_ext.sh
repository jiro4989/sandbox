#!/bin/bash

set -eu

target_dir=$1

find $target_dir -type f -printf "%TY-%Tm %p\n" |
  grep -v '/.git/' |
  grep -E "/[^./]*\.[^./]+$" |
  awk -F'[ .]' '{map[$1" ."$NF]++; sum++} END{for(key in map) {print key, map[key]} print "_", "total", sum}' |
  sort | 
  cat <(echo date extension count) - |
  column -t
