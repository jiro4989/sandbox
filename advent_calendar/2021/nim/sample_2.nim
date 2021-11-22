import logging
from os import sleep
from posix import onSignal, SIGTERM, SIGINT

var log = newConsoleLogger()
addHandler(log)

info "start daemon"

var running = true

onSignal(SIGTERM, SIGINT):
  info "signal received"
  running = false

while running:
  echo "start proc 1"
  sleep 5000
  echo "end proc 1"

  echo "start proc 2"
  sleep 5000
  echo "end proc 2"

  sleep 3000

info "end daemon"
