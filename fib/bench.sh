#!/bin/bash

go build gofib.go
nim c -d:release nimfib.nim

for i in go nim; do
  echo "== $i =="
  time ./${i}fib 1000000 > /dev/null
done
