#!/bin/bash

mkdir $HOME/go

go get -u github.com/cweill/gotests/...
go get -u github.com/mholt/archiver/cmd/archiver

# TUI
go get -u github.com/fatih/color
go get -u github.com/julienroland/keyboard-termbox
go get -u github.com/mattn/go-colorable
go get -u github.com/nsf/termbox-go

# vim-go
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/godoc

# Excel
go get -u github.com/tealeg/xlsx
go get -u github.com/loadoff/excl

go get -u github.com/BurntSushi/toml

# packages version
go get -u github.com/golang/dep/cmd/dep

# github release
go get -u github.com/tcnksm/ghr

# clipboard
go get -u github.com/atotto/clipboard/cmd/gocopy

# Debugger
go get -u github.com/derekparker/delve/cmd/dlv

go get -v github.com/alecthomas/gometalinter
gometalinter --install --update

# coverage
go get -u github.com/axw/gocov/gocov

# count srccode
go get -u github.com/hhatto/gocloc/cmd/gocloc

# クロスコンパイル
go get -u github.com/mitchellh/gox
