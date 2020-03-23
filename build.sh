#!/usr/bin/env bash

set -eux

# build.sh is used by netlify when deploying the site

if [ "$NETLIFY" != "true" ]
then
	echo "Not on Netlify; cowardly refusing to run"
	exit 1
fi

# If we are running on netlify (i.e. a deploy) and we are building tip then we
# need to grab the master of our cuelang.org/go and
# github.com/cue-sh/playground dependencies
if [ "$BRANCH" = "tip" ]
then
	GOPROXY=direct go get cuelang.org/go@master github.com/cue-sh/playground@master
	# Now force cuelang.org/go  through the proxy so that the /pkg.go.dev redirect works
	go get cuelang.org/go@$(go list -m -f={{.Version}} cuelang.org/go)
fi

# Main site
git submodule update -f --init --recursive
npm install
go generate ./...
hugo $@

# CUE playground
export GOBIN=$PWD/_functions
export CUELANG_ORG_DIST=$PWD
modCache=$(go env GOMODCACHE)
if [ "$modCache" = "" ]
then
	modCache=${GOPATH%%:*}/pkg/mod
fi
cd play
go mod download
mkdir moddownload
unzip -d moddownload $modCache/cache/download/$(go list -m -f={{.Path}}/@v/{{.Version}} github.com/cue-sh/playground).zip
bash moddownload/$(go list -m -f={{.Path}}@{{.Version}} github.com/cue-sh/playground)/dist.sh
