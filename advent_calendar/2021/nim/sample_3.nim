import logging
from os import sleep
from posix import onSignal, SIGTERM, SIGINT
import streams

var log = newConsoleLogger()
addHandler(log)

info "start daemon"

var running = true

onSignal(SIGTERM, SIGINT):
  info "signal received"
  running = false

var f = newFileStream("/tmp/tmp.dat", fmWrite)
var f2 = newFileStream("/tmp/tmp2.dat", fmWrite)

while running:
  echo "start proc 1"
  for i in 1..100_000_000:
    f.write("1")
  echo "end proc 1"

  echo "start proc 2"
  for i in 1..100_000_000:
    f2.write("2")
  echo "end proc 2"

  sleep 3000

close f
close f2
info "end daemon"
