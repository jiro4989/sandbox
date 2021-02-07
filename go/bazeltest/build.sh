#!/bin/bash

set -eux

bazel build //:bazeltest
