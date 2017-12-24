$scriptPath = $MyInvocation.MyCommand.Path
$parentPath = Split-Path -Parent $scriptPath

@(
  "chocolatey.ps1"
, "other.ps1"
, "git.ps1"
, "go.ps1"
, "vim.bat"
) | % { powershell "$parentPath\$_" }
