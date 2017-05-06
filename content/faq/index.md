+++
title = "FAQ"
+++

## About Pony

### How'd Pony come to be?

Check out ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/).

### Why's it called "Pony"?

Interesting question. We here that a lot. If you read enough of ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/), you'll get your answer.

## Compiling

### I get a "requires dynamic" error when compiling, how do I solve it?

```bash
/usr/bin/ld.gold: error: ./fb.o: requires dynamic R_X86_64_32 
  reloc against 'Array_String_val_Trace' which may 
  overflow at runtime; recompile with -fPIC
```

try running `ponyc` with the `--pic` flag.

For example:

```bash
ponyc --pic examples/helloworld
```
