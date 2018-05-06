#!/bin/bash

set -eu

find Character* -type f | grep -v Character4.1 | grep .png | while read -r f
do
  dn=`dirname $f`
  bn=`basename $f`
  num=`echo $bn | sed -r 's@character([0-9]+).*@\1@g'`
  num=`printf '%03d' $num`
  nfn=`echo $bn | sed -r 's@character[0-9]+@actor'$num'@g'`
  mv $f $dn/$nfn
done
