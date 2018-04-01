' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' プラグインの追加もれがひどい場合は
' 下記の数値を大きくしてみてください。
' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SHORT_WAIT = 20
LONG_WAIT = 200

' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
' ここまで
' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' 以降は編集する必要なし
' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




















set wshShell=Wscript.createObject("Wscript.Shell")

' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' 関数定義
' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

' ファイル名の先頭の文字の数を数えて返す。
' @param folder 検査対象フォルダ
' @param prefix1 調べる接頭語1
' @param prefix2 調べる接頭語2
' @return 見つけた文字数
function getPrefixCounter(folder, prefix1, prefix2)
  dim tmp
  tmp = 0
  for each file in folder.files
    if left(file.name, 1) = prefix1 or left(file.name, 1) = prefix2 then
      tmp = tmp + 1
    end if
  next
  getPrefixCounter = tmp
end function

' ファイル一覧から、引数で渡されてた2つのプレフィックスで始まる
' ファイルの数を数えて、
' GUI操作をするときにsendKeyする時のキーと、
' その後に使う回数のペアを保持する配列を返す
' @param folder 検査対象フォルダ
' @param prefix1 調べる接頭語1
' @param prefix2 調べる接頭語2
' @return ["sendKeyの値", プレフィックスで始まるファイルの数]
function getKeyMap(folder, prefix1, prefix2)
  dim keyMap(1)
  keyMap(0) = prefix1
  keyMap(1) = getPrefixCounter(folder, prefix1, prefix2)
  getKeyMap = keyMap
end function

' アルファベットキーとその登場回数のペアとなった
' 2次元配列を返す。
' @return [["a", 4], ["b", 1] ...]
function getAlphabetArray()
  ' カレントパスのファイル一覧から見つけたファイルの総数を取得
  set fso = createObject("Scripting.FileSystemObject")
  set folder = fso.getFolder(".")
  dim fileCount
  fileCount = 0
  for each file in folder.files
    fileCount = fileCount + 1
  next 
  ' このスクリプト自体の数も数えてしまうのでその分減算
  fileCount = fileCount - 1

  ' 各アルファベットのペアの2次元配列の生成
  dim alphabets(25)
  alphabets(0)  = getKeyMap(folder, "a", "A")
  alphabets(1)  = getKeyMap(folder, "b", "B")
  alphabets(2)  = getKeyMap(folder, "c", "C")
  alphabets(3)  = getKeyMap(folder, "d", "D")
  alphabets(4)  = getKeyMap(folder, "e", "E")
  alphabets(5)  = getKeyMap(folder, "f", "F")
  alphabets(6)  = getKeyMap(folder, "g", "G")
  alphabets(7)  = getKeyMap(folder, "h", "H")
  alphabets(8)  = getKeyMap(folder, "i", "I")
  alphabets(9)  = getKeyMap(folder, "j", "J")
  alphabets(10) = getKeyMap(folder, "k", "K")
  alphabets(11) = getKeyMap(folder, "l", "L")
  alphabets(12) = getKeyMap(folder, "m", "M")
  alphabets(13) = getKeyMap(folder, "n", "N")
  alphabets(14) = getKeyMap(folder, "o", "O")
  alphabets(15) = getKeyMap(folder, "p", "P")
  alphabets(16) = getKeyMap(folder, "q", "Q")
  alphabets(17) = getKeyMap(folder, "r", "R")
  alphabets(18) = getKeyMap(folder, "s", "S")
  alphabets(19) = getKeyMap(folder, "t", "T")
  alphabets(20) = getKeyMap(folder, "u", "U")
  alphabets(21) = getKeyMap(folder, "v", "V")
  alphabets(22) = getKeyMap(folder, "w", "W")
  alphabets(23) = getKeyMap(folder, "x", "X")
  alphabets(24) = getKeyMap(folder, "y", "Y")
  alphabets(25) = getKeyMap(folder, "z", "Z")
  getAlphabetArray = alphabets
end function

' 万が一他の画面に遷移したり、
' プログラム実行中にユーザが他の画面を選択した場合には
' プログラムを強制終了する
' @param title アクティブかどうかを調べる対象ウィンドウのタイトル
function checkActiveWindow(title)
  if not wshShell.appActivate(title) then
    msgBox("アクティブウィンドウが期待と異なっています。" & vbCR & "スクリプトを終了します。")
    WScript.quit 10
  end if
end function

' プログラムのメインロジック
function main()

  if wshShell.appActivate("プラグイン管理") then

    dim alphabets
    alphabets = getAlphabetArray()

    ' リスト一番下にカーソルを移動して選択
    wshShell.sendKeys("{END}")

    for each alpha in alphabets

      ' 出現回数が0のアルファベットは無視
      if 0 < alpha(1) then
        dim x
        for x = 1 to alpha(1)
          checkActiveWindow("プラグイン管理")
          ' プラグイン画面を開く
          wshShell.sendKeys("{ENTER}")
          WScript.sleep(LONG_WAIT)

          ' アルファベットキーのsendによって
          ' プレフィックスで始まるプラグイン位置にジャンプ
          wshShell.sendKeys(alpha(0))
          WScript.sleep(SHORT_WAIT)

          for y = 1 to x
            ' プレフィックス入力時点で選択されているので、
            ' 1の時はdown不要
            if not y = 1 then
              wshShell.sendKeys("{DOWN}")
              WScript.sleep(SHORT_WAIT)
            end if
          next

          checkActiveWindow("プラグイン")
          ' カーソル位置の要素を選択
          wshShell.sendKeys("{ENTER}")
          WScript.sleep(LONG_WAIT)
        next
      end if

      ' カーソル位置の要素を選択
      wshShell.sendKeys("{ENTER}")
      ' ここは画面の表示に時間がかかる場合があるので長いスリープを挟む
      WScript.sleep(LONG_WAIT)

      ' 要素をプラグインリストに追加
      wshShell.sendKeys("{ENTER}")
      WScript.sleep(SHORT_WAIT)
      checkActiveWindow("プラグイン管理")
    next

    msgBox("正常にスクリプトが終了しました。")

  else
    msgBox("プラグイン管理画面を表示してください。")
  end if

end function

' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

main()

