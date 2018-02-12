#!/bin/bash

set -eux

git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
sudo apt-get install ruby-dev
sudo gem install rails
