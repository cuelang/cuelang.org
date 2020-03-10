### `github.com/cuelang/cuelang.org` - the home of https://cuelang.org

Requirements:

* [NodeJS](https://nodejs.org/) `>= v12.14.1`
* [Go](https://golang.org/dl/) (stable version)
* [Hugo](https://github.com/gohugoio/hugo/releases) `== v0.56.3`

To build and serve the site locally:

```
./build.sh
hugo serve -D
```

The tour and spec and generated against the required version of the `cuelang.org/go` module:

```
go generate ./...
```

The generated tour and spec files are intentionally not committed.

### History

This site was setup using the following guides:

* https://gohugo.io/hosting-and-deployment/hosting-on-netlify/
* https://www.docsy.dev/docs/getting-started
* https://www.docsy.dev/docs/deployment/
