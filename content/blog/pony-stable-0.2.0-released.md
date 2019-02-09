+++
draft = false
author = "seantallen"
categories = [
    "Release",
]
date = "2019-02-08T00:00:00-04:00"
title = "Pony Stable 0.2.0 Released"
+++
Pony-stable 0.2.0 is a recommended release. It fixes a couple bugs that could result in end user issues.
<!--more-->

## Local dependencies are relative to invocation directory, not `bundle.json`

Prior to this change, given:

```
/> tree
.
├── pony-bar
│   ├── bar
│   │   └── bar.pony
│   └── bundle.json
└── pony-foo
    └── foo
        └── foo.pony
/> cd pony-bar
/pony-bar> stable add local ../pony-foo
/pony-bar> cd bar
/pony-bar/bar> stable env ponyc -d
Building builtin -> /usr/local/Cellar/ponyc/0.15.0/packages/builtin
Building . -> /pony-bar/bar
Error:
foo: couldn't locate this path
Error:
/pony-bar/bar/bar.pony:1:1: can't load package 'foo'
use "foo"
^
```
because stable is invoked from the `/pony-bar/bar` folder, the `../pony-foo` path refers to `/pony-bar/pony-foo`, which  doesn't exist. As of 0.2.0, will refer to `/pony-foo`. This is a breaking change where someone might have been relying on the previous behavior. However, the previous behavior was unintentional and was considered to be a bug.

## Don't process already-seen paths

Fix a bug where running `stable env ponyc` in a project that contains cyclic dependencies creates a process that never finishes, consuming more and more memory until it's killed.

### Fixed

- Don't process already-seen paths ([PR #97](https://github.com/ponylang/pony-stable/pull/97))

### Changed

- Resolve Local Dependencies From Bundle Path ([PR #78](https://github.com/ponylang/pony-stable/pull/78))