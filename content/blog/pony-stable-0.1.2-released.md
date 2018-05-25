+++
draft = false
author = "seantallen"
categories = [
    "Release",
]
date = "2018-05-25T07:26:01-04:00"
title = "Pony Stable 0.1.2 Released"
+++
Pony-stable 0.1.2 is a recommended release. It fixes a bug that could cause issues if you were using a dependency whose commit was on a non-master branch. 
<!--more-->

### Fixed

- Update usage of Env.exitcode to be compatible with ponyc 0.22.x ([PR #56](https://github.com/ponylang/pony-stable/pull/56))
- Fixed issue with the way the `.deps` directory is updated to avoid problems with non-master versions
