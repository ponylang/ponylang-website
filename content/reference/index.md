+++
title = "Reference"
+++


## Debugging 

- [Pony LLDB Cheatsheet]({{< relref "pony-lldb-cheatsheet.md" >}})

> A quickstart for debugging Pony with LLDB

- [Pony LLDB Extensions](https://github.com/aturley/pony-lldb)

> A collection of LLDB extensions for working with the Pony programming language.

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

- [Stable](https://github.com/ponylang/pony-stable)

> Simple dependency manager for the Pony language.

- Deploy Pony as a Unikernel

>  A unikernel is a deployment methodology that allows you to build your
  pony application as a vm instead of deploying on top of linux. This
  makes it run much faster and safer and takes a very 'no ops' approach
towards running applications. A side benefit is that being a tiny vm it
allows you to run your pony applications on osx with no
cross-compilation.

>  OPS is a unikernel builder/orchestrator that will build the vm and
  allow you to spin it up on various cloud providers.

>  First get obtain OPS - the unikernel builder/ochestrator:
  ```bash
  curl https://ops.city/get.sh -sSfL | sh
  ```

>  Compile your pony application normally:
  ```bash
  ponyc .
  ```
>  Create a simple config.json. This should just contain the name of the
pony program. :
  ```bash
  {
    "Args": ["my_program"]
  }
  ```
  Build and Run it:
  ```bash
  ops run -c config.json my_program
  ```

>  You've just built a deployable VM with nothing in it except your Pony
application.
