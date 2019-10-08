#!/bin/sh
set -e
set -x

git submodule update -f --init --recursive

PUSHD=$(pwd)
cd content/en/docs/tutorials/tour
go test .
go run gen.go
cd ${PUSHD}

# TODO
#   shell documentation
#   cue/doc/contribute.md
#

hugo $@
