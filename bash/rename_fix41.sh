#!/bin/bash

set -eu

find Character4.1 -type f | grep png | while read -r f
do
  nfn=`echo $f | sed -r 's@actor4@actor004@g'`
  mv $f $nfn
done
