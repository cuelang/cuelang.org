#!/bin/sh
set -e
set -x

git submodule update -f --init --recursive

PUSHD=$(pwd)
cd vendor/github.com/cuelang/cue/doc/tutorial/basics
go test .
go run gen.go
cd ${PUSHD}

cp -rv vendor/github.com/cuelang/cue/doc/tutorial/basics/tour content/en/docs/

# TODO
#   shell documentation
#   cue/doc/contribute.md
#

hugo $@
