#!/bin/bash

while :
do
  n=$((n+1))
  result=`shuf -e H e l l o`
  result=`echo $result | sed 's/ //g'`
  if [ "$result" = "Hello" ]; then
    echo "$n $result"
    exit 0
  fi
done
