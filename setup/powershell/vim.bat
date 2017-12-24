@echo off

cd %userprofile%
mkdir tmp

mkdir %userprofile%"\dotfiles\bundle"
cd %userprofile%"\dotfiles\bundle"
git clone https://github.com/Shougo/dein.vim.git

mklink %userprofile%"\.vimrc" %userprofile%"\dotfiles\.vimrc"
mklink %userprofile%"\.gvimrc" %userprofile%"\dotfiles\.gvimrc"
mklink %userprofile%"\.vimperatorrc" %userprofile%"\dotfiles\.vimperatorrc"
mklink %userprofile%"\.vrapperrc" %userprofile%"\dotfiles\.vrapperrc"

mkdir %userprofile%"\.vim"
mklink /D %userprofile%"\.vim\template" %userprofile%"\dotfiles\template"
mklink /D %userprofile%"\.vim\bundle" %userprofile%"\dotfiles\bundle"
mklink /D %userprofile%"\.vim\dict" %userprofile%"\dotfiles\dict"

mklink /D %userprofile%"\vimfiles" %userprofile%"\dotfiles\vimfiles"
