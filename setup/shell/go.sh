#!/bin/bash

mkdir $HOME/go

sudo add-apt-repository ppa:gophers/archive
sudo apt-get update
sudo apt-get install golang-1.10-go

go get -u -v github.com/therecipe/qt/cmd/..
go get -u github.com/ChimeraCoder/gojson/gojson
go get -u github.com/cweill/gotests/...
go get -u github.com/fatih/color
go get -u github.com/julienroland/keyboard-termbox
go get -u github.com/loadoff/excl
go get -u github.com/mattn/go-colorable
go get -u github.com/mattn/twty
go get -u github.com/mholt/archiver/cmd/archiver
go get -u github.com/nsf/gocode
go get -u github.com/nsf/termbox-go
go get -u github.com/otiai10/copy
go get -u github.com/tealeg/xlsx
go get -u github.com/therecipe/qt
go get -u github.com/urfave/cli
go get -u golang.org/x/oauth2
go get -u golang.org/x/oauth2/google
go get -u golang.org/x/tools/cmd/godoc
go get -u google.golang.org/api/gmail/v1
go get -u github.com/BurntSushi/toml
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/tcnksm/ghr
go get -u github.com/gohugoio/hugo

go get -v github.com/alecthomas/gometalinter
gometalinter --install --update

go get -d github.com/tcnksm/gcli
cd $GOPATH/src/github.com/tcnksm/gcli
go install

