+++
title = "JSON"
weight = 410
description = "How CUE integrates with the JSON data-interchange format."
+++

## Intro

CUE is a superset of JSON: any valid JSON file is a valid CUE file.
There is not much more integration you can get than that.
The main motivation to make it a superset was to promote familiarity.

{{< alert color="info" title="JSON's influence on CUE">}}
There are many design decisions in CUE that are a result of CUE being
a strict super set of JSON.
For instance, interpolations in CUE use the `"\(str)"` notation, rather than
the somewhat more common `"${str}"`.
The latter is, however, a valid JSON string and cannot be used interchangeably
with normal strings, as one cannot tell from the string itself
if it is to be used as a template or a verbatim string.
CUE's notation is _not_ valid JSON, meaning it is safe for CUE to give it
special treatment outside of the JSON spec.
This way 100% compatability is guaranteed.
{{< /alert >}}


## Generate JSON

The `cue export` command outputs CUE in a data format.
By default this is JSON.

Given the following file

{{< highlight none >}}
$ cat >> coordinates.cue << EOF
x: 43.45
y: -34.12
EOF

$ cue export coordinates.cue
{
    "x": 43.45,
    "y": -34.12
}
{{< /highlight >}}


## JSON in CUE

It may also be needed to deal with JSON inside a CUE file.
For instance, a Kubernetes ConfigMap may specify an embedded JSON file.
CUE provides a builtin JSON package to parse, generate, or validate
JSON from within CUE.


### Create

The builtin `encoding/json.Marshal` generates JSON from within CUE.

{{< blocks/section color="white" >}}
<div class="col">
{{< highlight none >}}
import "encoding/json"

configMap: data: "point.json":
    json.Marshal({
        x: 4.5
        y: 2.34
    })
{{< /highlight >}}
</div>

<div class="col">
{{< highlight json >}}
{
    "configMap": {
        "data": {
            "point.json": "{\"x\":4.5,\"y\":2.34}"
        }
    }
}
{{< /highlight >}}
</div>
{{< /blocks/section >}}

### Parse

The reverse is also possible
{{< blocks/section color="white" >}}
<div class="col">
{{< highlight none >}}
import "encoding/json"

data:  #"{"x":4.5,"y":2.34}"#
point: json.Unmarshal(data)
{{< /highlight >}}
</div>

<div class="col">
{{< highlight json >}}
{
    "data": "{\"x\":4.5,\"y\":2.34}",
    "point": {
        "x": 4.5,
        "y": 2.34
    }
}
{{< /highlight >}}
</div>
{{< /blocks/section >}}


### Validate

{{< highlight cue >}}
// dim.cue
import "encoding/json"

#Dimensions: {
    width:  number
    depth:  number
    height: number
}

// Validate JSON configurations embedded strings.
configs: [string]: json.Validate(#Dimensions)

configs: bed:      #"{ "width": 2, "height": 0.1, "depth": 2 }"#
configs: table:    #"{ "width": "34", "height": 23, "depth": 0.2 }"#
configs: painting: #"{ "width": 34, "height": 12, "depht": 0.2 }"#
{{< /highlight >}}

{{< highlight none >}}
$ cue vet dim.cue
configs.table: error in call to encoding/json.Validate: conflicting values number and "34" (mismatched types number and string):
    ./dim.cue:11:14
configs.painting: error in call to encoding/json.Validate: field "depht" not allowed in closed struct:
    ./dim.cue:11:14
{{< /highlight >}}
