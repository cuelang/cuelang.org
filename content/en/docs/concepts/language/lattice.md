+++
title = "Values and Types"
weight = 50
draft = true
+++

In this section we will describe what a value
For people that like a top-down approach to learning, this section gives
a conceptual handle of the true meaning of values.
For those liking a more bottom-up approach, this section can be read later.

This sections introduces two

## Intro

In CUE, values and types are all a kind of value.
This a the main concept from which CUE derives its strength!

{{% alert title="Image" color="warning" %}}
Image with value lattice here.
{{% /alert %}}

This image illustrates a simple lattice with some CUE values.
At the very top, there is a value called, somewhat unsurprisingly, _top_.
All values are an instance of _top_

Every two values in the lattice have a unique meet, or greatest lower bound.


## Top

At the top of the value lattice we have a value called _top_.
Any possible value is an instance of top.
It is commonly denoted as `⊤`,
but as most keyboards don't have a key for it, CUE uses the more agreeable `_`.


## Bottom, Error, and Undefined

At the bottom of CUE's value lattice sits a value called, well, _bottom_.
The bottom value, denoted `_|_`, is an instance of every value.
Unifying two seemingly incompatible values, like `2` and `3`, results in bottom.
So one can interpret bottom as an error.

As types are values, bottom is also an instance of every type.
Many languages introduce concepts to pair an error value or code along with
another value.
In Go, functions may have multiple return arguments,
resulting for instance, in the function signature `Compute() (int, error)`.
Functional languages often define monads.
In CUE, there is no such need, as bottom is already a valid value for any type.

Bottom can also mean undefined.
For instance, consider the two structs `{a?: 1}` and `{a?: 2}`
with the same optional fields, but with different, incompatible values.
As `1 & 2` results in `_|_`,
the result of combining, or unifying, these two is `{a?: _|_}`.
As field `a` is optional, however, this is not an error.
It merely indicates that field `a` must be undefined.
This makes sense.
We defined after all that field `a` was optional;
we can now just require to no longer define it.

<!--
For those familiar with type theory BHK interpretations,
`¬P` is rewritten as `P → ⊥`.
In other words, we can say that by getting `{a?: _|_}` we have found proof
that `a` should not be defined.
-->


## Finding the meet

For exa

## Finding the join

The `|`

- `int | string`, just that.
- `true | false` -> `bool` (actually equivalent now)
- `>= 0 | <0` -> `number`

This concept is not unique to CUE.
And because CUE unifies the concept of type and value, this actually covers
many different constructs in other languages, including sum types, enums,
and unions.
Combined with defaults, discussed next, it can also be used for
null coalescing or providing falling back value for a map lookup.


## Default values

Two parallel lattices.