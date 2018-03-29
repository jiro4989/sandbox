#!/bin/bash

# なんかぶっこわれる。htmlでうまく行く方法はないもんか
# curl -sL http://everything-you-do-is-practice.blogspot.jp/2017/09/curl-xml.html |
#  xmllint --format -

# XMLを整形してくれる
curl -sL http://www.ekidata.jp/api/s/1130224.xml | xmllint --format -

# JSONを整形してくれるんだと
curl -s "http://api.tumblr.com/v2/blog/david.tumblr.com/info\?api_key\=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4" |
  python -mjson.tool
