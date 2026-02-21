# Packages

## Official "3rd party" Packages

The Pony Developers maintain a number of packages that exist outside of the standard library that you can utilize. Each of the packages is tested nightly to make sure it works with the latest Pony compiler builds.

While the packages are maintained by us, we welcome contributions from the community at large. If you'd like to discuss contributing to any of the packages, please stop by the [contribute to Pony stream](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to-Pony).

### [appdirs](https://github.com/ponylang/appdirs)

Package for getting platform-specific application directories e.g. directory for user-based config.

### [crdt](https://github.com/ponylang/crdt)

Conflict-free replicated data types (CRDTs) for Pony, based on delta-state replication.

### [fork_join](https://github.com/ponylang/fork_join)

Pony parallel processing package.

### [github_rest_api](https://github.com/ponylang/github_rest_api)

Pony package for working with GitHub's REST API.

### [glob](https://github.com/ponylang/glob)

Pony package provides the ability find all pathnames matching a given pattern based on Unix shell rules.

### [http](https://github.com/ponylang/http)

HTTP client package.

### [http_server](https://github.com/ponylang/http_server)

Pony package for building HTTP server applications.

### [json](https://github.com/ponylang/json)

A JSON package for Pony.

### [logger](https://github.com/ponylang/logger)

A simple logging package for Pony.

### [lori](https://github.com/ponylang/lori)

A TCP networking library for Pony. Lori separates connection logic from actor scheduling — the TCP state machine lives in a plain class (`TCPConnection`) that your actor delegates to, rather than baking everything into a single actor the way the standard library's net package does. This gives you control over how your actor is structured while lori handles the low-level I/O.

Key features:

- Fallible sends — `send()` returns `(SendToken | SendError)` instead of silently dropping data, so the application always knows whether data was accepted
- Built-in SSL — switch from plain TCP to SSL by changing a single constructor call
- Connection limits — cap the number of concurrent connections a listener will accept
- Backpressure notifications — `_on_throttled` / `_on_unthrottled` callbacks let the application respond to socket pressure

### [peg](https://github.com/ponylang/peg)

A parsing expression grammar package for Pony.

### [postgres](https://github.com/ponylang/postgres)

Pure Pony Postgres client.

### [reactive_streams](https://github.com/ponylang/reactive_streams)

Pony implementation of [http://www.reactive-streams.org/](http://www.reactive-streams.org/).

### [redis](https://github.com/ponylang/redis)

Pure Pony Redis client.

### [regex](https://github.com/ponylang/regex)

Perl compatible regular expression support for Pony.

### [semver](https://github.com/ponylang/semver)

A semantic versioning package for Ponylang.

### [ssl](https://github.com/ponylang/ssl)

Pony wrappers for OpenSSL and LibreSSL.

### [templates](https://github.com/ponylang/templates)

A template engine for Pony.

### [uri](https://github.com/ponylang/uri)

URI library for Pony. Implements [RFC 3986](https://datatracker.ietf.org/doc/html/rfc3986) parsing, reference resolution, and normalization; [RFC 3987](https://datatracker.ietf.org/doc/html/rfc3987) IRI/URI conversion and IRI-aware encoding; and [RFC 6570](https://datatracker.ietf.org/doc/html/rfc6570) URI template expansion at all four levels.

### [valbytes](https://github.com/ponylang/valbytes)

Package to deal with multiple concatenated byte-arrays as if they were a single byte-array.

### [web_link](https://github.com/ponylang/web_link)

Parser for [RFC 8288](https://www.rfc-editor.org/rfc/rfc8288) (Web Linking) HTTP Link headers in Pony. Implements the link-value grammar from Section 3 including quoted-string parameters, OWS/BWS handling, and multi-link comma-separated headers.
