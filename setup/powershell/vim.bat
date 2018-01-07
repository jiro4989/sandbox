@echo off

rem 各種tmpファイルの配置場所の作成
mkdir %userprofile%\tmp

git clone https://github.com/jiro4989/dotfiles.git %userprofile%\dotfiles
git clone https://github.com/Shougo/dein.vim.git %userprofile%\dotfiles\vim\dein

mklink /d %userprofile%\.vim %userprofile%\dotfiles\vim\

rem 各種rcファイルのシンボリックリンクの追加
mklink %userprofile%\.vimrc %userprofile%\.vim\rc\.vimrc
mklink %userprofile%\.gvimrc %userprofile%\.vim\rc\.gvimrc
mklink %userprofile%"\.vimperatorrc" %userprofile%"\.vim\rc\.vimperatorrc"
mklink %userprofile%"\.vrapperrc" %userprofile%"\.vim\rc\.vrapperrc"

rem tomlファイルの配置場所の作成
mkdir  %userprofile%\.config
mkdir  %userprofile%\.config\vim
mklink /d %userprofile%\.config\vim\dein %userprofile%\.vim\rc\dein\
