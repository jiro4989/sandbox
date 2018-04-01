概要
==============================================================================

自作のスクリプト管理リポジトリ。

ディレクトリ構造
------------------------------------------------------------------------------

    scripts/
    ├── ext
    │   ├── bash
    │   ├── bat
    │   ├── gas
    │   ├── go
    │   ├── java
    │   ├── powershell
    │   ├── python
    │   └── vbs
    ├── proj
    ├── setup
    │   ├── powershell
    │   └── shell
    ├── update
    └── upgrade

### ext
拡張子別にスクリプトを管理する。
ほとんどが単一のスクリプトファイルのみで動作する。

### proj
複数のスクリプトや読み込みファイルがないと動作しないものを管理する。

### setup
環境構築スクリプトを管理する。
- powershellはWindows10用
- shellはubuntu用

### update
開発ツールなどのアップデートスクリプト

### upgrade
OSのアップグレード

メモ
------------------------------------------------------------------------------

### setup
必要な各種ファイル、作業フォルダをセットアップする

Ubuntu  
`./setup/shell/all.sh`

Windows  
`.\setup\powershell\all.sh`

### ipv6
下記の記事を参考にする。
http://l-w-i.net/t/ubuntu/ipv6_001.txt

こっちで恒久対応
http://zorinos.seesaa.net/article/438911113.html

### キーボード
LinuxMintの時はAltキーでウィンドウの位置操作を自分で設定しないといけない。
Winキー -> keyboard で適当な設定する。

<!-- vim:tw=78:ts=8: -->
