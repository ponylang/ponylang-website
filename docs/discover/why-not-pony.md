# Why not Pony?

There are many valid reasons to not use Pony. Amongst these are:

- Lack of API stability
- Lack of high-quality 3rd party libraries
- Limited native tooling

## API stability

Pony hasn't yet reached version 1.0. We regularly have releases that involve breaking changes. This lack of stability is plenty of reason for many projects to avoid using Pony.

## Batteries required

If your project is going to succeed or fail based on the size of community around the tools you are using, Pony is not a good choice for you. While it's possible to write stable, high-performance applications using Pony, you will have to do a decent amount of work. The pool of open source, ready to use Pony libraries is very small. If it's not in the standard library then odds are you are going to have to add it yourself, either by writing it from scratch in Pony or by wrapping an existing C library using Pony's excellent [C-FFI](https://tutorial.ponylang.io/c-ffi/) functionality.

## Tooling

There's a wide swath of tooling that some people have come to expect that isn't currently available for Pony. We don't have an IDE. You can use standard debuggers like GDB or LLDB but the experience still has some rough edges. If you are comfortable working with a basic text editor and using LLDB, VTune and other tools, you'll probably be ok. Just don't expect a full, robust ecosystem. We aren't there yet.

If your project isn't going to get a great deal of benefit from any of Pony's strengths, then you shouldn't use Pony. If you are writing a single threaded application without any overriding performance concerns, and you need access to a large community and wealth of libraries then you're much better off selecting another language. However, we hope that you see enough potential in Pony to start playing around with it even if it isn't right for your current project.
