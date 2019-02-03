' ==============================
' filename : StartAmpuTea1b.vbs
' author   : Jiro
' created  : December 12. 2015
' info     : ver1a - プログラム配布
'          : ver1b - コーディング規則の統一

Set WshShell=Wscript.CreateObject("Wscript.Shell")

' 下の""" で囲った部分にAmpuTeaの実行ファイルのパスを指定
' インストール先を変更しなかった場合のパス
' 	C:/Program Files (x86)/Steam/steamapps/common/Ampu-Tea/AmpuTea.exe
WshShell.Run """C:/Program Files (x86)/Steam/steamapps/common/Ampu-Tea/AmpuTea.exe"""
WScript.Sleep(500)
WshShell.AppActivate "Ampu-tea Configuration"
WshShell.SendKeys("{Enter}")
WScript.Sleep(300)
' ==============================
