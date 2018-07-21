$scriptPath = $MyInvocation.MyCommand.Path
$parentPath = Split-Path -Parent $scriptPath

choco install $parentPath\package.config -y
