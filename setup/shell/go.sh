#!/bin/bash

mkdir $HOME/go

sudo apt-get install golang -y
sudo apt-get install libgtk2.0-dev libglib2.0-dev libgtksourceview2.0-dev -y

go get github.com/mattn/go-gtk/gtk
go install github.com/mattn/go-gtk/gtk

gorepos=(
  "github.com/nsf/gocode"
  "golang.org/x/tools/cmd/godoc"
  "github.com/urfave/cli"
  "github.com/nsf/termbox-go"
  "github.com/mattn/go-colorable"
  "github.com/julienroland/keyboard-termbox"
  "github.com/goreleaser/goreleaser"
  "github.com/loadoff/excl"
  "github.com/mholt/archiver/cmd/archiver"
  "github.com/otiai10/copy"
  "github.com/tealeg/xlsx"
)
for repo in ${gorepos[@]}; do
  go get $repo
done

