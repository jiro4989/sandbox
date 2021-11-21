import logging
from os import sleep

var log = newConsoleLogger()
addHandler(log)

info "start daemon"

while true:
  echo "start proc 1"
  sleep 5000
  echo "end proc 1"

  echo "start proc 2"
  sleep 5000
  echo "end proc 2"

  sleep 3000

info "end daemon"
