+++
title = "Getting Started"
weight = 150
description = "Install CUE on your machine."
+++

The Go APIs can be used as is using Go's package manager.

The `cue` binary can be installed using one of the following methods.

## Binary install

### Download from GitHub

Binaries for various operating systems, including Linux, Windows, and Mac OS
can be downloaded from
[CUE releases section on Github](https://github.com/cuelang/cue/releases).


### Install using homebrew

In addition, CUE can be installed with using brew on MacOS and Linux:

```
brew install cuelang/tap/cue
```


## Install CUE from source

### Prerequisites

Go 1.12 or higher (see below)

### Installing CUE

To download and install the `cue` command line tool run

```
go get -u cuelang.org/go/cmd/cue
```

And make sure the install directory is in your path.

To also download the API and documentation, run

```
go get -u cuelang.org/go/cue
```


### Installing Go

#### Download Go

You can load the binary for Windows, MacOS X, and Linux at  https://golang.org/dl/. If you use a different OS you can install Go from source.

#### Install Go

Follow the instructions at  https://golang.org/doc/install#install.
Make sure the go binary is in your path.
CUE uses Go modules, so there is no need to set up a GOPATH.