# 概要

自作のスクリプト管理リポジトリ。

## 0_package_list.bat

pipでインストールしたパッケージ一覧の情報を更新する

### package_list.txt

依存するライブラリ一覧

## cntln.py

コマンドライン引数からディレクトリを指定すると
ディレクトリ配下のファイルの行数をカウントして表示します。

## convert.py

**使用非推奨**

コマンドライン引数からディレクトリを指定すると
特定ファイル配下のすべての文字列を置換する。

置換文字列はハードコーディングされている。

## dummy.py

ダブルクリックで動きます。
a-zと番号だけが割り振られたダミーファイルを生成します。

## flippicts.py

ダブルクリックで動作。

rightフォルダに存在するpng画像をすべて左右反転し、
ファイル名に含まれる \_R\_ というタグをすべて \_L\_ に変更して、
leftフォルダに出力する。

## mktvdb.py

JavaFXのTableViewで使用するデータベースクラスを作成するためのスクリプト

Make TableView Database
@param argv[1]       - ソースファイルの属するパッケージ名
@param argv[2]       - ソースファイルのクラス名
@param argv[3..size] - 可変長引数。定義したいプロパティの名前と型を : で区切る

### 使い方

```
user@pc $ python mktvdb.py app DB id:i name:s usable:b > DB.java
```

- args[1] : パッケージ名
- args[2] : クラス名
- args[3] : 変数名:変数の型の省略記

#### 型略記

- i : int
- s : String
- b : Boolean

## keybotter.py

コンソール上で動作するツイッタークライアント。

## timer.py

ダブルクリックで動きます。
指定の時間になったらポップアップを表示します。

## vtmp

テンポラリファイルを生成して、
パパっとソースを書いてテストするためのもの。

### jc

java compile

vtmpで生成されたtmp.javaをコンパイルして実行する。

## note

メモ書きスクリプト。  
ファイル名は日付。

