@echo off

git clone https://github.com/jiro4989/dotfiles.git %userprofile%\dotfiles
mkdir %userprofile%\dotfiles\bundle
git clone https://github.com/VundleVim/Vundle.vim.git %userprofile%\dotfiles\bundle\Vundle.vim
mklink /d %userprofile%\vimfiles %userprofile%\dotfiles\vim\
