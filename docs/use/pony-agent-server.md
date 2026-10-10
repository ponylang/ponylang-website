# Pony Agent Server

`pony-agent-server` is a query server that gives AI coding agents access to Pony type information from the compiler. It compiles a Pony package, then returns query results about types, definitions, scopes, and APIs over a JSON protocol. It is part of the [ponylang/ponyc](https://github.com/ponylang/ponyc) repository, built alongside the compiler.

`pony-agent-server` is experimental. The query interface is subject to change.

## How It Works

On startup, `pony-agent-server` compiles the package you point it at. Once compilation finishes, it accepts queries over stdin and writes responses to stdout — one JSON object per line in each direction. This is a standard stdio transport that AI agent tool integrations use.

When source files change, you can send the server a reload query without restarting it.

## Starting It

```text
pony-agent-server <package-directory> [-D define]...
```

The server accepts the same `-D` flags as `ponyc`. Run `pony-agent-server --queries` to see a summary of available queries.

## Using with Corral

For projects that use [corral](https://github.com/ponylang/corral) for dependency management, run `pony-agent-server` through `corral run` so that dependencies are on the package search path:

```bash
corral run -- pony-agent-server .
```

## What It Can Answer

`pony-agent-server` exposes type and definition information at source positions, scope visibility at a given location, and the full list of exports from a package. It can list the methods on a type filtered by what a particular reference capability can call, check whether one type is a subtype of another (using the compiler's actual subtype checker, not a reimplementation), and find every type that implements a given trait or interface. It also reports compilation errors from the most recent load.

## Using It with AI Agents

There are three ways to connect an AI agent to `pony-agent-server`:

- ponylang's [llm-skills](https://github.com/ponylang/llm-skills) will include guidance for agents that support skill loading.
- Add instructions to your project's `AGENTS.md` or `CLAUDE.md` telling your agent to use it.
- Prompt your agent directly during a session.

## Getting pony-agent-server

`pony-agent-server` is distributed via [ponyup](https://github.com/ponylang/ponyup) alongside `ponyc`. Installing a recent `ponyc` will also install `pony-agent-server`. See the [ponyc installation instructions](https://github.com/ponylang/ponyc/blob/main/INSTALL.md) for details.
