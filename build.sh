#!/bin/sh
set -e
set -x

git submodule update -f --init --recursive

PUSHD=$(pwd)
cat <<EOF > content/en/docs/references/spec.md
+++
title = "Language Specification"
+++
EOF
cat src/cue/doc/ref/spec.md >> content/en/docs/references/spec.md
cd content/en/docs/tutorials/tour
go test .
go run gen.go
cd ${PUSHD}

# TODO
#   shell documentation
#   cue/doc/contribute.md
#

hugo $@
