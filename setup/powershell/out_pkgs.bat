@echo off

powershell Set-ExecutionPolicy RemoteSigned
powershell .\out_pkgs.ps1
powershell Set-ExecutionPolicy Restricted
