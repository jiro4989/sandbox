# 概要

砂場。書捨てコードの積もる場所。

### play_game

RPGツクールMVのアプリをLinux環境で動作させるための簡単スクリプト。

#### 使い方

[NW.js](https://nwjs.io/)を取得して下記のように配置。  

    .
    |-- game1
    |   `-- package.json
    `-- nw
        `-- nw

このディレクトリ構成でplay_gameを実行して、引数にディレクトリ名を渡すか、スクリ
プト実行時に表示される番号を指定するとゲームが起動する。

```bash
play_game game1
```

---

## メモ

### ipv6

下記の記事を参考にする。
http://l-w-i.net/t/ubuntu/ipv6_001.txt

こっちで恒久対応
http://zorinos.seesaa.net/article/438911113.html

### キーボード

LinuxMintの時はAltキーでウィンドウの位置操作を自分で設定しないといけない。
Winキー -> keyboard で適当な設定する。

### github

.netrcをdotfilesに配置しているので$HOME配下に配置してパスワードを変更する。
