シグナルを受信して安全に停止するプログラムを作る
===

この記事は[2021年Nimアドベントカレンダー](https://qiita.com/advent-calendar/2021/nim)1日目の記事です。

# 概要

シグナルを考慮せずに常駐プログラムを実装すると、デプロイやサーバのシャットダウ
ンでプロセスが停止したことでシステムに異常が発生する場合があります。

こういった事象を回避するために、シグナルを受けて安全に常駐プログラムを停止する
実装をNimでやってみます。

# 検証環境

| 項目 | 値 |
| --- | --- |
| OS | Ubuntu 20.04 (Windows 10 Home + WSL2) |
| Nim | 1.6.0 |
| Python | 3.8.5 |
| Pip | 20.0.2 |
| Supervisor | 4.2.2 |

# 単純なプログラムの実装例

問題がある単純な無限ループする常駐プログラムを書きました。
以下がそのサンプルコードです。

無限ループに入ったら、2種類の何らかの処理をして、3秒待機し、を永遠に繰り返すだ
けの単純なプログラムです。

```sample_1.nim
import logging
from os import sleep

var log = newConsoleLogger()
addHandler(log)

info "start daemon"

while true:
  echo "start proc 1"
  sleep 5000
  echo "end proc 1"

  echo "start proc 2"
  sleep 5000
  echo "end proc 2"

  sleep 3000

info "end daemon"
```

これをビルドして、作成された実行可能ファイルを`/tmp`に配置します。

```bash
nim c sample_1.nim
mv sample_1 /tmp/sample_1
```

## daemonとしてsupervisordに登録する

常駐プログラムを実装したので、実際にサーバ上で動かすことを想定して常駐プログラ
ムとして動かせるようにします。今回はsupervisorを使います。

WSL2環境でsystemdを動かせるようにするのが面倒だったのでforegroundで動作させます。
`apt`でインストールする必要もなかったので`pip`でインストールします。

```bash
pip install supervisor
```

以下は今回のプログラムを動かすために用意したsupervisor用の設定ファイルです。必
要最小限のものだけを定義しています。

```sample_1.conf
[supervisord]
nodaemon=true

[inet_http_server]
port=127.0.0.1:8000

[program:sample_1]
command=/tmp/sample_1
stopwaitsecs=30
```

設定ファイルをsupervisordで動かします。

```bash
supervisord -c ./sample_1.conf
```

## 動作確認

プログラムができたので動作をみてみます。

ログを確認するために、ローカルで立ち上がったsupervisordの画面を確認します。以下
のURLにブラウザでアクセスします。

<http://localhost:8000>

そしてsample\_1のログを確認します。
以下のようなログが確認できます。

```sample_1.log
INFO start daemon
start proc 1
end proc 1
start proc 2
end proc 2
```

無限ループに入っているので問題なく動いています。

## この実装の問題点

このプログラムには動作中にシグナルを受け取ると問答無用で処理を中断される問題があります。

supervisordのログを確認するために、ローカルで立ち上がったsupervisordの画面を確認します。
以下のURLにブラウザでアクセスします。

<http://localhost:8000>

次に `start proc 1` というログが出力された直後に sample\_1 を stop します。

そしてログを確認すると、以下のようなログが確認できます。

```sample_1.log
INFO start daemon
start proc 1
end proc 1
start proc 2
end proc 2
start proc 1
end proc 1
start proc 2
```

start のログが出ているものの、 end のログがでていません。
つまり、endの処理が完了する前に処理が打ち切られています。

処理が打ち切られると何が問題かというと、プログラムの作りによってはシステムが異
常な状態になってしまします。

例えばロックファイルを作って他のプロセスの割り込みを防止し、処理が完了したらロ
ックファイルを削除するようなプログラムの場合、ロックファイルが残り続けてしまい
ます。つまり、他のプロセスは永遠に処理を開始できなくなります。

```example.nim
import os

createDir("/tmp/sample.lock")

# 何らかの処理に時間がかかる

# 処理が中断されるとロックファイルが残り続ける
removeDir("/tmp/sample.lock")
```

あるいは、外部のAPIを叩いてデータを連携するようなプログラムの場合、データの連携
状態が中途半端になります。

```example.nim
callExternalApiA()

# 何らかの処理に時間がかかる

# 処理が中断されるとこっちのAPIへのデータ連携がされなくなる
callExternalApiB()
```

この例のようにシグナルを受信してプロセスが終了される場合は、以下の 2 ケースで起こりえます。

1. アプリケーションをデプロイしてプロセスを再起動するケース
1. サーバのシャットダウン、再起動

(1)のケースは、先の例でsupervisordの機能でプロセスを停止したケースがこれに該当します。
supervisordではプロセスを停止する場合にデフォルトでSIGTERMが送信されます。

> `stopsignal`
>
> The signal used to kill the program when a stop is requested. This can be any
> of TERM, HUP, INT, QUIT, KILL, USR1, or USR2.
>
> Default: TERM

参考: [Supervisor Configuration File](http://supervisord.org/configuration.html)

先の例では stop 操作をしたことでSIGTERMがプロセスに送信されました。
プロセスはSIGTERMを受信したことでプログラムを終了します。

これについては、タイミングを見計らうことでなんとかできなくもないです。つまり、
前述のプログラムはループの最後にsleepを挟んでいるので、次のループが開始する前に
プロセスを停止して、実行ファイルを交換すればよいのです。

しかしながら、タイミング調整を手動で行うのは危険であり、ミスを誘発しえます。

デプロイのタイミング調整を行うために、サーバ上でコマンドを叩かないといけないか
もしれないので、デプロイ作業が大変になります。

(2)のケースについても同様です。
shutdownコマンドでサーバをシャットダウンする時に全てのプロセスにSIGTERMが送信されます。

デプロイの時であれば1つ1つプログラムのログを見ながらプロセスの停止タイミングを
調整することで回避することも可能でしたが、シャットダウンの場合は全てのプロセス
にシグナルが送信されます。同様のつくりのプログラムが大量に存在した場合、タイミ
ング調整は現実的に不可能です。

いずれにせよ、人力でのタイミング調整は自動化の観点からも安全性の観点からも良く
ないことは自明です。よって、プログラム側に「シグナルを受けて安全に停止できる機
構」を設けてしまうのがベターと言えます。

## 解決方法

前述のプログラムに改修を加えてシグナルを受信したらループを脱出する処理を追加しました。
以下がそのプログラムです。

```nim
import logging
from os import sleep
from posix import onSignal, SIGTERM, SIGINT

var log = newConsoleLogger()
addHandler(log)

info "start daemon"

var running = true

onSignal(SIGTERM, SIGINT):
  info "signal received"
  running = false

while running:
  echo "start proc 1"
  sleep 5000
  echo "end proc 1"

  echo "start proc 2"
  sleep 5000
  echo "end proc 2"

  sleep 3000

info "end daemon"
```

加えた変更内容は以下の2つです

1. 無限ループをフラグ変数で制御するようにした
1. シグナルを受信すると、無限ループのフラグ変数を false にするようにした
   1. シグナル関連の機能は標準ライブラリの `posix` モジュールに存在する

これにより、ループ処理の間は処理を中断されることはなくなり、ループの終端に到達
してからループを脱出するようになりました。

以下は処理途中にプロセスをstopした動作確認のログです。

```sample_2.log
INFO start daemon
start proc 1
end proc 1
start proc 2
end proc 2
start proc 1
end proc 1
start proc 2
INFO signal received
end proc 2
INFO end daemon
```

startとendの間でシグナルを受信し、ループの最後のログを出力して、最後にプログラ
ムの最後の行のログが出力されています。一連の処理は中断されずに最後まで処理され
ていると言えます。

これで任意のタイミングでプロセスを停止されても安全にプログラムが停止するように
なりました。たとえばデプロイを自動化するためにスクリプト経由でデプロイしたり、
サーバの再起動等も好きなタイミングで実施できるようになりました。

改修を加えた実装ではSIGTERMだけでなくSIGINTを受信した場合も安全にプログラムを停
止します。SIGINTはいわゆるCtrl-Cを押した時に送信されるシグナルです。

前述のプログラムをsupervisord経由ではなく、直接コマンドラインから起動して、
Ctrl-Cを押してみます。いきなりプロセスが停止したりはせず、ループ内の処理を実行
しきってからループを脱出していることを確認できます。

## 注意点

一点、注意があります。
supervisord側で「SIGKILL送信までの待機時間」の調整が必要な点です。

supervisordではプロセスを停止するためにSIGTERMを送信した後、ある一定の時間まで
にプロセスが停止を完了しなかった場合に、強制的にSIGKILLを送信してプロセスを停止
します。

> `stopwaitsecs`
>
> The number of seconds to wait for the OS to return a SIGCHLD to supervisord
> after the program has been sent a stopsignal. If this number of seconds
> elapses before supervisord receives a SIGCHLD from the process, supervisord
> will attempt to kill it with a final SIGKILL.
>
> Default: 10

参考: [Supervisor Configuration File](http://supervisord.org/configuration.html)

デフォルト値は10秒です。

先のプログラムではスリープが合計13秒挟まるため、この `stopwaitsecs` をデフォル
ト値のままにしているとタイミングによってはSIGKILLで処理を中断される可能性があり
ます。よって、実際の処理時間を鑑みて `stopwaitsecs` の時間を調整する必要があり
ます。

こういったSIGTERM -> SIGKILLまでの待機時間を調整するための設定は、daemon管理用
サービスだと大体どれにでもあるはずです。systemdにも同様の設定が存在します。

参考: `TimeoutStopSec` を参照
[MAN page of systemd.service](https://man7.org/linux/man-pages/man5/systemd.service.5.html)

各自の使っているdaemon管理サービスのマニュアルに従って設定しましょう。

# まとめ

以下の内容を書きました

1. シグナルを考慮しないで常駐プログラムを作ると停止シグナルを受けた時に問題が起
   こり得る
1. Nimにおいては `posix` モジュールの `onSignal` を使うことでシグナル受信時の振
   る舞いを設定できる
1. シグナル受信時にループ変数を制御することで、ループ処理を安全に脱出できる
1. ループを脱出するまでの待機時間が、daemon管理サービスのSIGKILLまでの待機時間
   を超えるとSIGKILLでプロセスを強制的に停止される。SIGKILLまでの待機時間は
   daemon管理サービスのマニュアルに従って、実際の処理時間に基づいて適切な値を設
   定する

以上です
