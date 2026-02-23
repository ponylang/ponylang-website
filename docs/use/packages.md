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

### [hobby](https://githbu.com/ponylang/hobby)

Hobby is a simple HTTP web framework for Pony, powered by [Stallion](https://github.com/ponylang/stallion). It provides radix-tree routing with named and wildcard parameters, two-phase middleware (before/after), route groups with shared prefixes and middleware, and streaming responses via chunked transfer encoding. Routes are registered through method chaining and frozen into an immutable router when the server starts, giving you a mutable-friendly setup phase followed by a fully `val` runtime with no locking or coordination overhead.

Hobby is designed to feel lightweight while taking full advantage of Pony's type system and reference capabilities. Handlers are `val` ΓÇö safe to share across concurrent connections without copying. The `Context` is `ref`, so middleware and handlers can read and mutate request state without juggling `iso` ownership. If you're building an HTTP service in Pony and want a familiar route/middleware/handler model without fighting the capability system, Hobby is a good place to start.
```

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

### [stallion](https://github.com/ponylang/stallion)

Stallion is an HTTP/1.x server library for Pony, built on [lori](https://github.com/ponylang/lori). Rather than hiding connections behind an opaque server object, Stallion asks you to write the connection actor yourself - your actor owns an `HTTPServer` instance and receives HTTP lifecycle callbacks directly. There are no hidden internal actors, no implicit concurrency, and no magic. You get a typed request with a pre-parsed URI, a `Responder` for sending replies, and a `ResponseBuilder` state machine for constructing well-formed responses. Pipelined requests are queued and responses are sent in order, even when your actor handles them out of sequence.

Stallion supports both complete and streaming responses. Complete responses are pre-serialized via `ResponseBuilder` for efficient repeated use. Streaming responses use chunked transfer encoding with flow control - each chunk gets an asynchronous acknowledgement callback so producers can match their send rate to the network. Configuration is explicit: parser limits, idle timeouts, pipelining depth, and TLS are all opt-in via `ServerConfig`. If you want a minimal, transparent HTTP layer that fits naturally into Pony's actor model without imposing its own abstractions, Stallion is the foundation to build on.

### [templates](https://github.com/ponylang/templates)

A template engine for Pony.

### [uri](https://github.com/ponylang/uri)

URI library for Pony. Implements [RFC 3986](https://datatracker.ietf.org/doc/html/rfc3986) parsing, reference resolution, and normalization; [RFC 3987](https://datatracker.ietf.org/doc/html/rfc3987) IRI/URI conversion and IRI-aware encoding; and [RFC 6570](https://datatracker.ietf.org/doc/html/rfc6570) URI template expansion at all four levels.

### [valbytes](https://github.com/ponylang/valbytes)

Package to deal with multiple concatenated byte-arrays as if they were a single byte-array.

### [web_link](https://github.com/ponylang/web_link)

Parser for [RFC 8288](https://www.rfc-editor.org/rfc/rfc8288) (Web Linking) HTTP Link headers in Pony. Implements the link-value grammar from Section 3 including quoted-string parameters, OWS/BWS handling, and multi-link comma-separated headers.
