#!/bin/bash

set -eu

yes | ./install.sh
yes | ./setup.sh
yes | ./vim.sh

# 手動でないとだめな箇所があるため
./others.sh
