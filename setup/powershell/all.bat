@echo off

powershell Set-ExecutionPolicy RemoteSigned
powershell .\all.ps1
powershell Set-ExecutionPolicy Restricted

pause

