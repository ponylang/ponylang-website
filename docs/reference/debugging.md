# Debugging

## Debugging Pony Programs

[`LLDB`](https://lldb.llvm.org/) is the primary step debugger we use with Pony. However, you can use any similar step debugger like [`gdb`](https://www.sourceware.org/gdb/).

We have a couple of resources that can help get up to speed with using LLDB with Pony.

We have a quickstart guide: [Pony LLDB Cheat Sheet](pony-lldb-cheatsheet.md). Which if you have some experience with debuggers like LLDB, should be enough to get up going.

There's also a collection of [Pony LLDB Extensions](https://github.com/ponylang/pony-lldb-extensions) that can help improve your Pony/LLDB experience.

### Debugging Pony with Visual Studio Code {#visual-studio-code}

In order to debug programs in the Visual Studio Code debugger (either on Windows or with GDB or LLDB on Unix), you need to set the `debug.allowBreakpointsEverywhere` setting to `true`, so you can set breakpoints in `.pony` files.  Then make a launch configuration that runs your program.

## Tracking Memory Usage

Interested in tracking Pony runtime memory consumption? Checkout ["Making Pony track memory usage"](pony-track-memory-usage.md).
