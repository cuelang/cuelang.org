+++
title = "YAML"
weight = 420
description = "How CUE integrates with the YAML data-serialization standard."
+++

## Intro

Unlike with JSON, CUE is not a superset of YAML.
One of the design goals of CUE was to be easily machine generatable and
modifyable.
The sensitivity to indentation and the lexical obscurity of the typing of
tokens make YAML too bug prone for this purpose.

Consider this piece of yaml:

{{< highlight none >}}
phrases:
  quote1:
    lang: en
    text: Never regret anything that made you smile.
    attribution: Mark Twain

  proverb:
    lang: no
    text: Stemmen som sier at du ikke klarer det, lyver.
{{< /highlight >}}

See the problem?
The language for the Norwegian proverb is set to `no`, which is interpreted
as `false` in CUE.

Luckily, CUE can help catch those pesky YAML quickly and swiftly.


## Command line tool

### Validate YAML files

The `vet` command of the `cue` command line tool can validate
YAML files using a CUE schema.

Consider these two files:

{{< highlight yaml >}}
# ranges.yaml
min: 5
max: 10
---
min: 10
max: 5
{{< /highlight >}}

{{< highlight cue >}}
// check.cue
min?: *0 | number    // 0 if undefined
max?: number & >min  // must be strictly greater than min if defined.
{{< /highlight >}}

The `cue vet` command can verify that the values in `ranges.yaml`
are correct by just mentioning the two files on the command line.

{{< highlight none >}}
$ cue vet checks.cue
max: invalid value 5 (out of bound >10):
    ./check.cue:2:15
    ./data.yaml:5:7
{{< /highlight >}}

### Import YAML

The `import` command of the `cue` command line tool can convert YAML files
into CUE.
It can even embedded structured YAML and JSON and convert those recursively.


## YAML in CUE

The `encoding/yaml` builtin package provides various builtins to
parse, generate, or validate YAML from within CUE.

### Validate

If the YAML string from our introduction were embedded within a CUE file,
the fix would be the following.

{{< highlight none >}}
import "encoding/yaml"

// Phrases defines a schema for a valid phrase.
Phrases :: {
    phrases: { <_>: Phrase }

    Phrase :: {
        lang:         LanguageTag
        text:         !=""
        attribution?: !="" // must be non-empty when specified

    }
    LanguageTag :: =~"^[a-zA-Z0-9-_]{2,}$"
}

// phrases is a YAML string with a field phrases that is a map of Phrase
// objects.
phrases: yaml.Validate(Phrases)

phrases: """
    phrases:
      # A quote from Mark Twain.
      quote1:
        lang: en
        text: Never regret anything that made you smile.
        attribution: Mark Twain

      # A Norwegian proverb.
      proverb:
        lang: no
        text: Stemmen som sier at du ikke klarer det, lyver.
    """
{{< /highlight >}}

By defining a schema (called definition in CUE) for the allowed values of a YAML
string, we were able to catch the error before it made it into production.

{{< highlight none >}}
$ cue vet dim.cue
phrases: error in call to encoding/yaml.Validate: conflicting values false and
LanguageTag (mismatched types bool and string):
    ./dim.cue:17:10
{{< /highlight >}}


### Create

The builtin `encoding/yaml.Marshal` generates JSON from within CUE.

{{< blocks/sidebyside >}}
<div class="col">
{{< highlight none >}}
import "encoding/yaml"

configMap data "point.yaml":
    yaml.Marshal({
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
            "point.yaml": "x: 4.5\n\"y\": 2.34\n"
        }
    }
}
{{< /highlight >}}
</div>
{{< /blocks/sidebyside >}}

### Parse

The converse is also possible
{{< blocks/sidebyside >}}
<div class="col">
{{< highlight none >}}
import "encoding/yaml"

data: """
    x: 4.5
    y: 2.34
    """
point: yaml.Unmarshal(data)
{{< /highlight >}}
</div>

<div class="col">
{{< highlight json >}}
{
    "data": "x: 4.5\ny: 2.34",
    "point": {
        "x": 4.5,
        "y": 2.34
    }
}
{{< /highlight >}}
</div>
{{< /blocks/sidebyside >}}
