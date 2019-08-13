+++
title = "Basic types"
weight = 100
draft = true
+++

## Null

## Booleans


## Numbers

CUE numbers have arbitrary precision.
Non-integral numbers are encoded as arbitrary-precision decimal numbers.

{{% alert title="Why decimal numbers" color="info" %}}
CUE uses arbitrary-precision decimal numbers instead of the more usual
floating point numbers.
The kind of data CUE is expected to deal with is often written and consumed
by humans.
A simple number as `example` can already not be expressed accurately in
a `float64`.
This issue is resolves in its entirety by keeping numbers as decimals.
{{% /alert %}}


### Integers

### Floats


## Strings and Bytes

### Interpolation

### Multiline strings

### Raw strings
