#!/bin/bash

set -eu

docker run \
  -e RENOVATE_TOKEN="${RENOVATE_TOKEN}" \
  --rm -it renovate/renovate:slim \
  jiro4989/sandbox
