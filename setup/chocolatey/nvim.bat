@echo off

mklink /d %userprofile%\AppData\Local\nvim %userprofile%\.vim
mklink /d %userprofile%\AppData\Local\nvim\init.vim %userprofile%\.vimrc

