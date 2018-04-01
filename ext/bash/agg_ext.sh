#!/bin/bash

set -eu

target_dir=$1
find $target_dir -type f |
  grep -vE "/\.git/|\.(xml|config|txt|gitignore|png)$" |
  grep -E "/[^./]*\.[^./]+$" |
  sed -r 's@^.*\.([^.]+)$@\1@g' |
  sort |
  uniq |
  while read -r ext
    do
      find $target_dir -type f |
        grep -E "\.$ext\$" |
        xargs ls --full-time |
        awk '{print $6, $9}' |
        sed -r 's@-[0-9]{2} @ @g' |
        sed -r 's@( .*\.)([^.]+)$@\1\2 \2@g' |
        awk '{map[$1]++} END{ for (key in map) { print key, $3, map[key] } }'
    done |
      sort |
      cat <(echo date extension count) - |
      column -t
