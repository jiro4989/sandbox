# nim/sdl2

Installing libraries.

こっちでは駄目だった。

```bash
sudo apt update -y

# hg コマンドのインストール
sudo apt install -y mercurial

# SDL2のライブラリのインストール
sudo apt install -y libsdl2{,-image,-net,-ttf,-gfx,-mixer}-dev

# hgコマンドがないと動かないっぽい
nimble install platformer

platformer # TTFファイルを開けずに終了
```

こっちなら動いた。

```bash
# 手動ビルド
ghq get def-/nim-platformer
cd ~/src/github.com/def-nim-platformer
nimble build
./platformer # こっちなら動く
```
