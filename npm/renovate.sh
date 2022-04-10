#!/bin/bash

set -eu

docker run \
  -e RENOVATE_TOKEN="${RENOVATE_TOKEN}" \
  -v /tmp:/tmp -v /var/run/docker.sock:/var/run/docker.sock \
  --rm -it renovate/renovate:slim \
  jiro4989/sandbox
