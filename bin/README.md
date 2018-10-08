# bin

$HOME/binに配置してPATHを通して使う、普段づかい用のスクリプト

## play_game

RPGツクールMVのアプリをLinux環境で動作させるための簡単スクリプト。

### 使い方

[NW.js](https://nwjs.io/)を取得して下記のように配置。  

    .
    |-- game1
    |   `-- package.json
    `-- nw
        `-- nw

このディレクトリ構成でplay_gameを実行して、引数にディレクトリ名を渡すか、スクリ
プト実行時に表示される番号を指定するとゲームが起動する。
