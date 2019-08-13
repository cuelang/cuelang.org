+++
title = "Composite types"
weight = 300
draft = true
+++

CUE really only knows one type of composite type: a _struct_.
Map, lists, records, and tuples, are all expressed in this one type.

{{% alert title="Why the name struct?" color="info" %}}
- short for "feature structure", the model on which CUE was based
- Go structs
{{% /alert %}}

- *maps*: struct with arbitrary fields of the same key and value type.
- *lists*: a struct with integer indices where the number of elements
           needs to equal the highest index.
- *tuple*: a list constraint to a specific length.
- *record*: a struct with a string key with a fixed number of possibly optional fields
- *associative list*: a struct which key is derived from its element values.

## Structs

## Closed structs

## Lists

<!-- TODO: once implemented
## Associative lists
-->

<!-- TODO: do we even want to bring this up?
## Functions

Structs can be used as functions, although CUE limits recursion artificially.
-->
