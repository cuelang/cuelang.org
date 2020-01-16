#!/bin/sh
set -e
set -x

git submodule update -f --init --recursive

cd cloned
git clone -n https://github.com/cuelang/cue
cd cue
git checkout 317163484ec5d79259a4ea6524d3870419510639
cd ../..

PUSHD=$(pwd)
cat <<EOF > content/en/docs/references/spec.md
+++
title = "Language Specification"
+++
EOF
cat cloned/cue/doc/ref/spec.md >> content/en/docs/references/spec.md
cd content/en/docs/tutorials/tour
go test .
go run gen.go
cd ${PUSHD}

# TODO
#   shell documentation
#   cue/doc/contribute.md
#

hugo $@
