# Packages

The Pony Developers maintain a number of packages that exist outside of the standard library that you can utilize. Each of the packages is tested nightly to make sure it works with the latest Pony compiler builds.

While the packages are maintained by us, we welcome contributions from the community at large. If you'd like to discuss contributing to any of the packages, please stop by the [contribute to Pony stream](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to-Pony).

## Networking

### [hobby](https://github.com/ponylang/hobby)

Hobby is a simple HTTP web framework for Pony, powered by [Stallion](https://github.com/ponylang/stallion). It provides radix-tree routing with named and wildcard parameters, two-phase middleware (before/after), route groups with shared prefixes and middleware, and streaming responses via chunked transfer encoding. Routes are registered through method chaining and frozen into an immutable router when the server starts, giving you a mutable-friendly setup phase followed by a fully `val` runtime with no locking or coordination overhead.

Hobby is designed to feel lightweight while taking full advantage of Pony's type system and reference capabilities. Handlers are `val` - safe to share across concurrent connections without copying. The `Context` is `ref`, so middleware and handlers can read and mutate request state without juggling `iso` ownership. If you're building an HTTP service in Pony and want a familiar route/middleware/handler model without fighting the capability system, Hobby is a good place to start.

### [http](https://github.com/ponylang/http)

HTTP client package.

### [http_server](https://github.com/ponylang/http_server)

Pony package for building HTTP server applications.

### [lori](https://github.com/ponylang/lori)

A TCP networking library for Pony. Lori separates connection logic from actor scheduling — the TCP state machine lives in a plain class (`TCPConnection`) that your actor delegates to, rather than baking everything into a single actor the way the standard library's net package does. This gives you control over how your actor is structured while lori handles the low-level I/O.

Key features:

- Fallible sends — `send()` returns `(SendToken | SendError)` instead of silently dropping data, so the application always knows whether data was accepted
- Built-in SSL — switch from plain TCP to SSL by changing a single constructor call
- Connection limits — cap the number of concurrent connections a listener will accept
- Backpressure notifications — `_on_throttled` / `_on_unthrottled` callbacks let the application respond to socket pressure

### [mare](https://github.com/ponylang/mare)

Mare is a WebSocket server library for Pony, built on [lori](https://github.com/ponylang/lori). It implements RFC 6455 and provides a callback-driven API for handling WebSocket connections. You write an actor that implements `WebSocketServerActor` and responds to connection events — `on_open`, `on_text_message`, `on_binary_message`, and `on_closed` — and mare handles the protocol framing, upgrade handshake, and connection lifecycle. Configuration is explicit: bind address, port, and SSL are set through `WebSocketConfig`.

### [ssl](https://github.com/ponylang/ssl)

Pony wrappers for OpenSSL and LibreSSL.

The package is organized into two sub-packages. `ssl/crypto` provides one-shot hash functions (MD5, SHA-1, SHA-256, SHA-512, and others), streaming digests, HMAC-SHA-256, PBKDF2-SHA-256 key derivation, cryptographic random bytes, and constant-time comparison. `ssl/net` provides `SSLContext` for TLS configuration, `SSL` for transport-agnostic encryption/decryption via memory BIOs, and `SSLConnection` — a `TCPConnectionNotify` wrapper that adds TLS to any existing TCP connection transparently. ALPN negotiation and X.509 hostname verification are supported. Compile with `-Dopenssl_1.1.x`, `-Dopenssl_3.0.x`, or `-Dlibressl` to select the underlying library.

### [stallion](https://github.com/ponylang/stallion)

Stallion is an HTTP/1.x server library for Pony, built on [lori](https://github.com/ponylang/lori). Rather than hiding connections behind an opaque server object, Stallion asks you to write the connection actor yourself - your actor owns an `HTTPServer` instance and receives HTTP lifecycle callbacks directly. There are no hidden internal actors, no implicit concurrency, and no magic. You get a typed request with a pre-parsed URI, a `Responder` for sending replies, and a `ResponseBuilder` state machine for constructing well-formed responses. Pipelined requests are queued and responses are sent in order, even when your actor handles them out of sequence.

Stallion supports both complete and streaming responses. Complete responses are pre-serialized via `ResponseBuilder` for efficient repeated use. Streaming responses use chunked transfer encoding with flow control - each chunk gets an asynchronous acknowledgement callback so producers can match their send rate to the network. Configuration is explicit: parser limits, idle timeouts, pipelining depth, and TLS are all opt-in via `ServerConfig`. If you want a minimal, transparent HTTP layer that fits naturally into Pony's actor model without imposing its own abstractions, Stallion is the foundation to build on.

### [uri](https://github.com/ponylang/uri)

URI library for Pony. Implements [RFC 3986](https://datatracker.ietf.org/doc/html/rfc3986) parsing, reference resolution, and normalization; [RFC 3987](https://datatracker.ietf.org/doc/html/rfc3987) IRI/URI conversion and IRI-aware encoding; and [RFC 6570](https://datatracker.ietf.org/doc/html/rfc6570) URI template expansion at all four levels.

### [web_link](https://github.com/ponylang/web_link)

Parser for [RFC 8288](https://www.rfc-editor.org/rfc/rfc8288) (Web Linking) HTTP Link headers in Pony. Implements the link-value grammar from Section 3 including quoted-string parameters, OWS/BWS handling, and multi-link comma-separated headers.

## Databases

### [postgres](https://github.com/ponylang/postgres)

Pure Pony Postgres client.

Postgres is a pure Pony PostgreSQL driver with no libpq dependency — it implements the wire protocol directly. It supports simple queries, parameterized queries (both unnamed and named prepared statements), COPY IN/OUT for bulk data transfer, row streaming with bounded memory via portal suspension, SSL/TLS, and SCRAM-SHA-256 authentication. The API is fully async and callback-driven: you implement receiver interfaces (`ResultReceiver`, `CopyInReceiver`, `StreamingResultReceiver`, etc.) and the `Session` actor calls back with results or errors. Query execution is serialized within a session — for concurrency, create multiple sessions.

### [redis](https://github.com/ponylang/redis)

Pure Pony Redis client.

The client is built on [lori](https://github.com/ponylang/lori) and supports strings, keys, hashes, lists, sets, and pub/sub, with builder primitives for type-safe command construction. Any Redis command not covered by a builder can be sent as a raw byte array. Commands are pipelined by default — each `execute()` sends immediately without waiting for prior responses. The client supports both RESP2 and RESP3 protocols, SSL/TLS, and Redis 6.0+ ACL authentication. Backpressure is bounded: a configurable send buffer rejects commands when full rather than growing without limit. Note that this package has not yet had a formal release.

## Data Formats and Parsing

### [json](https://github.com/ponylang/json)

A JSON package for Pony.

The package provides `JsonDoc` for parsing and serializing JSON, with `JsonObject`, `JsonArray`, and the `JsonType` union covering all JSON value types. JSON integers (no decimal point) become `I64`; numbers with a fractional part or exponent become `F64`. Building JSON is done by mutating `JsonObject.data` and `JsonArray.data` directly, then calling `string()` to serialize. A `JsonExtractor` class offers chainable navigation for drilling into parsed structures — convenient for reading, though not recommended in hot paths. To send parsed JSON between actors, wrap the parse call in a `recover` block to produce a `val` or `iso` reference.

### [peg](https://github.com/ponylang/peg)

A parsing expression grammar package for Pony.

The library offers two ways to define parsers. You can build grammars programmatically using Pony operator overloading — `*` for sequence, `/` for ordered choice, `-` for skip, `.many()` for repetition — which makes grammar definitions read close to standard PEG notation. Alternatively, you can write grammars in `.peg` text files and compile them at runtime. Both approaches produce the same `Parser val` type, which parses input into a labeled AST of nodes and tokens. The library supports hidden channels for automatic whitespace skipping, separated lists, forward declarations for recursive rules, and positional error reporting with source context.

### [regex](https://github.com/ponylang/regex)

Perl compatible regular expression support for Pony.

The library wraps PCRE2 (the 8-bit variant) via FFI, with JIT compilation enabled by default and a graceful fallback to interpreted matching. UTF-8 mode is always on. The `Regex` class compiles a pattern once and provides `apply` for matching, `replace` for substitution (single or global), `split` for splitting, and `matches` for iterating over all non-overlapping matches. Both numbered and named capture groups are supported. PCRE2 compile-time options like case-insensitive or multiline mode are set via inline flags in the pattern (e.g., `(?i)`, `(?m)`). The library requires `libpcre2-8` to be installed on the system.

### [semver](https://github.com/ponylang/semver)

A semantic versioning package for Pony.

The library is organized into three sub-packages. `semver/version` handles parsing, validation, comparison, and stringification of semver 2.0.0 version strings, including pre-release fields and build metadata. `semver/range` provides interval-based version ranges with inclusive/exclusive bounds. `semver/solver` is a constraint-based dependency resolver that takes a set of available artifacts with their version-constrained dependencies and finds a compatible combination using a backtracking search. Parsing never throws — `ParseVersion` always returns a `Version` object, and `is_valid()` plus the `errors` field indicate whether parsing succeeded.

### [templates](https://github.com/ponylang/templates)

A template engine for Pony.

Templates uses `{{ ... }}` delimiters and supports variable substitution, dot-notation property access, `for` loops over sequences, `if` and `ifnotempty` conditionals, and single-argument function calls. Templates are compiled into an immutable `val` representation that can be shared across actors and rendered repeatedly with different values. Custom functions (e.g., for escaping or formatting) are registered at parse time via `TemplateContext`. The engine is intentionally minimal — there is no template inheritance, includes, or `else` clauses.

### [valbytes](https://github.com/ponylang/valbytes)

Package to deal with multiple concatenated byte-arrays as if they were a single byte-array.

`ByteArrays` lets you concatenate byte arrays without copying data. Each `+` operation wraps the existing data and the new chunk in a tree node, making concatenation O(1). You can then index into the combined structure, search for subsequences, slice with `select`/`drop`/`take` (also zero-copy), or read little-endian multi-byte integers — all as if the bytes were contiguous. When you do need a flat array, `trim` and `array` materialize the data. `ByteArrays` is `val` (immutable), so it is safe to share across actors. The typical use case is accumulating data from I/O in chunks and processing it later without intermediate copies.

## External Services

### [github_rest_api](https://github.com/ponylang/github_rest_api)

Pony package for working with GitHub's REST API.

The library covers a subset of the GitHub REST API — repositories, issues, issue comments, labels, pull requests, commits, releases, and issue search. Operations are async and return promises. Two API styles are available: call operation primitives directly, or chain methods on model objects starting from a `GitHub` entry point. Authentication is via an optional personal access token. Paginated endpoints return objects with `prev_page()` and `next_page()` methods. The library does not aim for full API coverage — it implements what the Pony project's own tooling needs and grows on demand.

## Concurrency and Distribution

### [crdt](https://github.com/ponylang/crdt)

Conflict-free replicated data types (CRDTs) for Pony, based on delta-state replication.

The library provides twelve CRDT types covering counters (grow-only, positive-negative, and causal), sets (grow-only, two-phase, timestamp-based, add-wins and remove-wins observed-remove), registers (last-write-wins and multi-value), a timestamped log, and a composable keyed collection. All types use delta-state replication — mutator methods return a delta containing only the new information, which you send to other replicas instead of the full state. Convergence is commutative and idempotent, so deltas can arrive in any order and be applied more than once without harm. The library handles the data structures and serialization; you provide the transport and logical timestamps.

### [fork_join](https://github.com/ponylang/fork_join)

Pony parallel processing package.

Fork_join handles the plumbing of distributing data processing across multiple actors. You supply four components: a `Generator` that produces work items on demand, a `Worker` that processes them, a `WorkerBuilder` that creates worker instances, and a `Collector` that aggregates results. The library creates one worker actor per scheduler thread (configurable), pulls items from the generator as workers become available, and delivers results to the collector. Work items must be independent — there is no inter-worker communication or ordering guarantee. The generator can pre-partition data in bulk or produce items one at a time for natural load balancing. Early termination is supported from both the job owner and the collector side.

### [reactive_streams](https://github.com/ponylang/reactive_streams)

Pony implementation of [http://www.reactive-streams.org/](http://www.reactive-streams.org/).

The package maps the Reactive Streams specification to Pony's actor model. Publishers and subscribers are actor interfaces; the `Subscription` connecting them is passed as `iso` to enforce single-owner semantics at the type level. No data flows until the subscriber signals demand via `request(n)`, giving full subscriber-driven backpressure. The library includes `Broadcast` and `Unicast` subscriber managers that handle demand tracking and bounded queuing, so building a publisher is a matter of implementing `ManagedPublisher` and calling `publish()` when data is available.

## Utilities

### [appdirs](https://github.com/ponylang/appdirs)

Package for getting platform-specific application directories e.g. directory for user-based config.

Appdirs gives you the correct OS-specific directory paths for user data, config, cache, logs, and state. On Linux it follows the XDG Base Directory Specification, on macOS it uses `~/Library/...` paths (with an opt-in XDG mode for CLI tools that want consistent cross-platform behavior), and on Windows it calls the Known Folders API. All methods are partial — they can fail if the home directory is not set or the OS API call fails. The library computes paths but does not create directories.

### [glob](https://github.com/ponylang/glob)

Pony package that provides the ability to find all pathnames matching a given pattern based on Unix shell rules.

Glob supports `*` (match within a directory), `**` (match across directories), `?` (single character), and `[seq]`/`[!seq]` (character classes). You can match patterns against strings with `fnmatch`, filter a list of names with `filter`, or walk the filesystem with `glob` and `iglob`. Unlike many glob implementations, this one exposes what each wildcard matched via capturing groups — the `filter` and `iglob` APIs return the matched substrings alongside each result. The library depends on [regex](https://github.com/ponylang/regex) and requires PCRE2 on the system.

### [logger](https://github.com/ponylang/logger)

A simple logging package for Pony.

Logger provides four log levels (`Fine`, `Info`, `Warn`, `Error`) and a generic `Logger[A]` class that accepts any type with a conversion lambda. For string logging, use `StringLogger`. The idiomatic usage pattern is `logger(Warn) and logger.log("message")` — Pony's short-circuit evaluation of `and` means the log message is never constructed when the level is suppressed. `Logger` is `val`, so a single instance can be shared across actors. Output goes to any `OutStream`; formatting is customizable via the `LogFormatter` interface, and the default formatter includes source file, line, and column from the call site.
