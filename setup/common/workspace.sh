#!/bin/bash

REPO_DIR=$HOME/workspace/github/repos

mkdir -p $REPO_DIR
mkdir -p $HOME/tmp
git clone https://github.com/jiro4989/scripts $REPO_DIR/scripts
git config --global core.editor vim
