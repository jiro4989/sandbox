#!/bin/bash

# jqは外部ツールなんでapt-get必須
# sudo apt-get install -y jq
cat $0 | grep -E '^###' | sed -r 's@^###@@g' | jq .

###{"key1":"value1","key2":"value2"}
