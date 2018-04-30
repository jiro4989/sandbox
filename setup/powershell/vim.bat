@echo off

git clone https://github.com/jiro4989/dotfiles.git %userprofile%\dotfiles
git clone https://github.com/Shougo/dein.vim.git %userprofile%\dotfiles\vim\dein
mklink /d %userprofile%\vimfiles %userprofile%\dotfiles\vim\
