# スクリプトまとめ

## mktvdb.py

JavaFXのTableViewで使用するレコードクラスを作成するスクリプト

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

## pytimer.py

テキストファイル内の時間と音声ファイル情報から
自動で音を鳴らして警告をする。

## keybotter.py

コンソール上で動作するツイッタークライアント。

## flippicts.py

rightフォルダに存在するpng画像をすべて左右反転し、  
ファイル名に含まれる \_R\_ というタグをすべて \_L\_ に変更して、  
leftフォルダに出力する。
