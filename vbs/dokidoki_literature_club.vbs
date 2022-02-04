'
' ドキドキ文芸部2周目のメインメニュー画面を表示した直後に実行する。
'
' 実行方法:
'   wscript.exe dokidoki_literature_club.vbs
'
Set WshShell = Wscript.CreateObject("Wscript.Shell")

if WshShell.AppActivate("Doki Doki Literature Club Plus") then
  WshShell.SendKeys("{UP}")
  WScript.Sleep(500)

  Dim LoopCounter
  LoopCounter = 0
  Do While LoopCounter < 200
    '
    ' DDLCを終了する
    '
    WshShell.SendKeys("{UP}")
    WScript.Sleep(500)
    WshShell.SendKeys("{Enter}")
    WScript.Sleep(500)
    WshShell.SendKeys("{Enter}")
    WScript.Sleep(4000)
    
    '
    ' DDLCを起動する
    '
    WshShell.SendKeys("{UP}")
    WScript.Sleep(1000)
    WshShell.SendKeys("{Enter}")
    WScript.Sleep(10000)

    LoopCounter = LoopCounter + 1
  Loop
end if
