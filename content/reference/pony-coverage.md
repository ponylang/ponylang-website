+++
title = "Coverage Reports for Pony"
+++

## Using kcov to create Coverage Reports

Pony compiles to plain binaries. When compiled with `--debug` these contain `DWARF` debugging information about the location of each instruction etc.

[kcov](https://github.com/SimonKagstrom/kcov) is a tool that uses this `DWARF` information to associate the executed parts of a binary with the source code they originated from.

### Compiling the Pony Program

In order to create coverage reports for a Pony program execution, the Pony program to run needs to be compiled with `--debug`.

### Running kcov

[kcov](https://github.com/SimonKagstrom/kcov) runs a given binary and takes a bunch of patterns for where to search for the connected source code and where not to.

An example run could look like the following.

This assumes you have your code inside the directory `my_proj`, your binary has been compiled to `bin/test`. The code you want to create coverage for is in `my_proj` but you have some test-files, that you want to exclude:

```bash
mkdir out
kcov --include-pattern="$PWD/my_proj" --exclude-pattern="$PWD/my_proj/test,$PWD/my_proj/_test.pony" ./out bin/test
```

This command will generate an HTML coverage report in the `out` directory. It will report coverage for all source files in `$PWD/my_proj`, but not for `$PWD/my_proj/test` and `$PWD/my_proj/_test.pony`, as these are test files for which we do not need coverage.

It is recommended to use absolute file paths for the include and exclude patterns as these match the file locations found in the `DWARF` debugging information.

## Reading kcov Coverage Reports

Lines covered are marked green, lines not covered are marked red.

If lines of your code are not marked at all, it means that these parts were not part of the binary. Pony strips away parts of your code during compilation that are never reached. So in this case it might be a good idea to write tests that cover these parts of your code.

