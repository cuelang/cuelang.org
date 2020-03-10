#!/bin/sh
set -e
set -x

# build.sh is used by netlify when deploying the site and locally when ensuring
# you environment is complete

# If we are running on netlify (i.e. a deploy) and we are building tip then we
# need to grab the master of our cuelang.org/go dependency
if [ "$NETLIFY" = "true" ] && [ "$BRANCH" = "tip" ]
then
	GOPROXY=direct go get cuelang.org/go@master
fi

git submodule update -f --init --recursive
npm install
go generate ./...

# If we are running on netlify (i.e. a deploy) build the site
if [ "$NETLIFY" = "true" ]
then
	hugo $@
fi
