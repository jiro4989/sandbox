choco list -localonly | sls "(chocolatey|packages installed)" -NotMatch | % {
  echo ([string]$_).Split(" ")[0]
} | Out-File packages.txt -Encoding utf8
