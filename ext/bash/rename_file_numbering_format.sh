#!/bin/bash

# rename_file_numbering_format.sh.sh はファル名のナンバリングの規則性を変更します。

set -eu

find . -type f | grep .png | while read -r f
do
  dn=`dirname "$f"`
  bn=`basename "$f"`
  pref=`echo "$bn" | sed -r 's@(.*)([0-9])([0-9]{2})\.png@\1@g'`
  pref_idx=`echo "$bn" | sed -r 's@(.*)([0-9])([0-9]{2})\.png@\2@g'`
  pref_idx=$((pref_idx + 1))
  number=`echo "$bn" | sed -r 's@(.*)([0-9])([0-9]{2})\.png@\3@g'`
  nbn="${pref}_`printf '%03d' $pref_idx`_0$number.png"
  mv "$f" "$dn/$nbn"
done
