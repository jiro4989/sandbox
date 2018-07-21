@echo off

powershell Set-ExecutionPolicy RemoteSigned
powershell .\chocolatey.ps1
powershell Set-ExecutionPolicy Restricted

pause
