#!/bin/sh
set -e
set -x

git submodule update -f --init --recursive

cd src
git clone -n https://github.com/cuelang/cue
cd cue
git checkout 6cb0878a1ef86cd2e63dc3bd31f32811ecf69730
cd ../..

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
