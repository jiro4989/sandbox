$scriptPath = $MyInvocation.MyCommand.Path
$parentPath = Split-Path -Parent $scriptPath

cat $parentPath\packages.txt | % { choco install $_ -y }
