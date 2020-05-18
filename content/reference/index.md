+++
title = "Reference"
+++


## Debugging

- [Pony LLDB Cheatsheet]({{< relref "pony-lldb-cheatsheet.md" >}})

> A quickstart for debugging Pony with LLDB

- [Pony LLDB Extensions](https://github.com/aturley/pony-lldb)

> A collection of LLDB extensions for working with the Pony programming language.

### Visual Studio Code

In order to debug programs in the Visual Studio Code debugger (either on Windows or with GDB or LLDB on Unix), you need to set the `debug.allowBreakpointsEverywhere` setting to `true`, so you can set breakpoints in `.pony` files.  Then make a launch configuration that runs your program.

## Coverage

How to obtain coverage for runs of pony programs or test executions

- [Coverage Reports for Pony]({{< relref "pony-coverage.md" >}})

## Performance

- [Pony Performance Cheatsheet]({{< relref "pony-performance-cheatsheet.md" >}})

> How to get the best performance from your Pony code.

## Other helpful tools

- [Pony Patterns](https://patterns.ponylang.io/)

> Pony Patterns is a cookbook style collection of patterns for working with Pony. Most folks aren't familiar with writing actor-model based code. Even fewer are familiar with doing it in a typed language that features causal messaging. Wondering how to do something? Check out the patterns and see if there's one that solves your problem. Patterns is a curated community-driven project. Feel free to open an issue requesting a pattern on how to do X, or open a PR to contribute your own pattern.

- [Library Project Starter](https://github.com/ponylang/library-project-starter/blob/master/USAGE.md)

> The Library Project Starter is designed to get you up and running with everything you need to start writing your own excellent Pony library.

- [Corral](https://github.com/ponylang/corral)

> Simple dependency manager for the Pony language.
