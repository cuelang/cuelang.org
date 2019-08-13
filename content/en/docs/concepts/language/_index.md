+++
title = "The CUE Language"
weight = 100
draft = true
+++

<!--
Approach of this introduction: first teach everything that is needed to use
CUE as a data definition language. Introduce things needed for data generation
later.
-->

Maybe this belongs in an introduction section.

CUE is a pure and lazy constraint-based language that is a super set of JSON
and has its roots in logic programming.
Pure means operations have no side-effects.
There is no way to modify values, one can only compose new ones from others.
Lazy means that the values are only evaluated when needed.

CUE unifies several concepts of things that are usually separate concepts
in other languages.
For instance, CUE unifies the concepts of types and concrete values and
considers them all to be values.
On top of that, all these values are neatly ordered in a lattice,
a partial order that ensures that for any two values there is a unique
least upper bound (or join) and greatest lower bound (or meet).
Many of CUEs real-world applications rely on this property
and give CUE its ultimate power.

Another example where CUE merges concepts is that it only has a single type
of composite value, called a _struct_.
What would be list, maps, records, and tuples in other languages
are all structs in CUE with different constraints applied to them.
Even functions are just structs in CUE, as we will see.

Finally, in general CUE takes quite a different approach to composing data
from other modern data-driven languages.
Composition follows for applying constraints, rather than cascading
modifications on base templates.
Validation code doubles as templates.

{{% alert title="TODO" color="warning" %}}
Reference formal spec and tutorial as alternative ways of getting to know the
language.
{{% /alert %}}

Conceptualize CUE

JSON
```
path: value
```

CUE
```
selection of nodes: constraints
```