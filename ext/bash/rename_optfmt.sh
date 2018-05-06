#!/bin/bash

set -eu

find Character* -type f | grep -v Character4.1 | grep .png | while read -r f
do
  if [[ "$f" =~ .*_(stand|face)[0-9]{3}[^.].* ]]; then
    opt=`echo $f | sed -r 's@.*_(stand|face)[0-9]+([^.]+).png@\2@g'`
    case "$opt" in
      "o" )
        num=002
        ;;
      "p" )
        num=003
        ;;
    esac
    nfn=`echo $f | sed -r 's@_(stand|face)@_\1_'$num'_@g' | sed -r 's@(_[0-9]+)(o|p)@\1@g'`
  else
    nfn=`echo $f | sed -r 's@_(stand|face)@_\1_001_@g'`
  fi
  mv $f $nfn
done
