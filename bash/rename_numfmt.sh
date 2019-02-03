#!/bin/bash

set -eu

find Character* -type f | grep .png | while read -r f
do
  i=`echo $f | sed -r 's@.*_(stand|face)([0-9]+).*@\2@g'`
  i=`printf '%03d' $i`
  nfn=`echo $f | sed -r 's@(.*_)(stand|face)([0-9]+)(.*)@\1\2'$i'\4@g'`
  mv $f $nfn
done
