+++
title = "FAQ"
+++

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
