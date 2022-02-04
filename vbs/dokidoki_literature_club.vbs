'
' ドキドキ文芸部2周目のメインメニュー画面を表示した直後に実行すること
'
Set WshShell=Wscript.CreateObject("Wscript.Shell")

if WshShell.AppActivate("Doki Doki Literature Club Plus") then
  WshShell.SendKeys("{UP}")
  WScript.Sleep(500)
  WshShell.SendKeys("{Enter}")
  WScript.Sleep(500)
  WshShell.SendKeys("{Enter}")
end if
