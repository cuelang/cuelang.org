+++
title = "References"
weight = 600
description = "Further documentation on CUE, including references to the language specification."
+++


## Contributing

CUE's maintains both a Gerrit and Github repository.
The Gerrit repository is the source of truth, but changes are accepted
in both repositories.
See the [Contribution Guide](https://github.com/cuelang/cue/blob/master/doc/contribute.md)
for more details on how to contribute.


## Tool references

The `cue` tool comes with build in help pages.
These are also reflected
[here](https://github.com/cuelang/cue/blob/master/doc/cmd/cue.md).
<!-- TODO: keep these in sync automatically.
See https://github.com/cuelang/cue/issues/10
-->


## Language Specification

The source of truth of how the CUE language should behave is encoded in the
[CUE language specification](https://cuelang.org/docs/references/spec/).
Notes on the formalism underlying the specification can be found
[here](https://github.com/cuelang/cue/blob/master/doc/ref/impl.md).


## API References

The CUE Go APIs in the main repo are organized as follows:

- [**cmd**](https://godoc.org/cuelang.org/go/cmd):
  The CUE command line tool.
- [**cue**](https://godoc.org/cuelang.org/go/cue):
  core APIs related to parsing, formatting, loading and running CUE programs.
  These packages are used by all other packages, including the command line tool.
- [**doc**](https://godoc.org/cuelang.org/go/doc):
  [CUE documentation](/docs/references),
  including tutorials and the reference manual.
- [**encoding**](https://godoc.org/cuelang.org/go/encoding):
  Packages for converting to and from CUE, including adaptors for YAML, JSON,
  Go, Protobuf, and OpenAPI.
- [**pkg**](https://godoc.org/cuelang.org/go/pkg):
  Builtin packages that are available from within _CUE_ programs.
  These are typically not used in Go code.
