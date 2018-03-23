#!/bin/bash

mkdir $HOME/go

sudo apt-get install golang -y
sudo apt-get install libgtk2.0-dev libglib2.0-dev libgtksourceview2.0-dev -y

go get github.com/mattn/go-gtk/gtk
go install github.com/mattn/go-gtk/gtk

go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/godoc
go get -u github.com/urfave/cli
go get -u github.com/nsf/termbox-go
go get -u github.com/mattn/go-colorable
go get -u github.com/julienroland/keyboard-termbox
go get -u github.com/goreleaser/goreleaser
go get -u github.com/loadoff/excl
go get -u github.com/mholt/archiver/cmd/archiver
go get -u github.com/otiai10/copy
go get -u github.com/tealeg/xlsx
go get -u golang.org/x/oauth2
go get -u golang.org/x/oauth2/google
go get -u google.golang.org/api/gmail/v1
go get -u github.com/therecipe/qt
