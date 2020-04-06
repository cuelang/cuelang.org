// Copyright 2019 CUE Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// gentipredirect regenerates a simple Hugo markdown file that acts as a redirect
// to the @master module documentation root on pkg.go.dev
package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os/exec"
	"strings"

	// imported for side effect of module being available in cache
	_ "cuelang.org/go/pkg"
)

func main() {
	log.SetFlags(log.Lshortfile)

	var cueVersion bytes.Buffer
	cmd := exec.Command("go", "list", "-m", "-f={{.Version}}", "cuelang.org/go")
	cmd.Stdout = &cueVersion
	if err := cmd.Run(); err != nil {
		log.Fatalf("failed to run %v; %v", strings.Join(cmd.Args, " "), err)
	}

	content := fmt.Sprintf(`---
type: redirect
redirectURL: https://pkg.go.dev/cuelang.org/go@%v
---`, strings.TrimSpace(cueVersion.String()))

	const target = "pkg.go.dev.md"

	if err := ioutil.WriteFile(target, []byte(content), 0666); err != nil {
		log.Fatalf("failed to write to %v; %v", target, err)
	}
}
