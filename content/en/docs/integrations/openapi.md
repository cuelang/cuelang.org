+++
title = "OpenAPI and CRDs"
weight = 470
description = "How CUE integrates with OpenAPI, an API description format for REST."
+++

OpenAPI is a standard for the description of REST APIs.
Describing value schema is one aspect of this.
In the [Schema Definition](/docs/usecases/datadef) section we already
talked about the relationship between CUE and OpenAPI.

One aspect of OpenAPI is to define data schema.
CUE supports converting CUE values to such schema.
As CUE is more expressive than OpenAPI, it is not possible to generate
a fully accurate OpenAPI schema.
But CUE makes a best effort to encode as much as possible.


## Generate OpenAPI

CUE currently only supports generating OpenAPI through its API.
The Istio project has a
[command line tool](https://github.com/istio/tools/tree/master/cmd/cue-gen)
to generate OpenAPI build on this API.

Generating an OpenAPI definition can be as simple as
{{< highlight go >}}
import "cuelang.org/go/encoding/openapi"

func genOpenAPI(inst *cue.Instance) ([]byte, error) {
    b, err := openapi.Gen(inst, nil)
    if err != nil {
        return nil, err
    }

    var out = &bytes.Buffer{}
    _ = json.Indent(out, b, "", "   ")
    return out.Bytes(), nil
}

{{< /highlight >}}

The [cuelang.org/go/encoding/openapi](https://godoc.org/cuelang.org/go/encoding/openapi)
package provides options to make a definition self-contained,
expand references, filtering constraints, and so on.

If expanding references is selected it will ensure the output is
in the Structural OpenAPI form, which is required for CRDs 1.15.
