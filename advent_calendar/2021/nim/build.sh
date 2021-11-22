#!/bin/bash

set -eux

nim c sample_1.nim
nim c sample_2.nim
mv sample_1 /tmp/sample_1
mv sample_2 /tmp/sample_2
supervisord -c sample_2.conf
