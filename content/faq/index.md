+++
title = "FAQ"
+++

## About Pony {#about-pony}

### How'd Pony come to be? {#early-history}

Check out ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/).

### Why's it called "Pony"? {#why-the-name-pony}

Interesting question. We hear that a lot. If you read enough of ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/), you'll get your answer.

### What makes Pony different? {#how-is-pony-different}

See the ["What makes Pony different"]({{< relref "discover/index.md#what-makes-pony-different" >}}) section of ["Discover"]({{< relref "discover/index.md" >}}).

### Why would I use Pony instead of language X? {#why-pony-instead-of-x}

That's a hard question to answer. Language X is probably very compelling for some problems. It's probably less compelling for others. Such is computers. In the end, the best we can do is tell you what Pony is good at and you can make the decision for yourself. To learn more about Pony, we suggest checking out the ["Discover"]({{< relref "discover/index.md" >}}) section of the website. There's a portion of that section called ["Why Pony"]({{< relref "discover/index.md#why-pony" >}}) that might answer your question.

### Where can I find the Pony roadmap?

There is no official roadmap. Pony is a volunteer driven project. Unlike many programming languages, we don't have corporate backing. Our users add features and fix issues based on their needs. Pony users solve the problems that matter to them, and we all benefit.

Many of us who are regular contributors share some general goals as we move towards an official 1.0 release. We are working towards making a Pony a stable, rock-solid platform for writing high-performance, concurrent applications.

We invite you to join our small but growing community and help push Pony forward. We're still at an early stage, and new community members can have a huge influence on the language. Join us!

## Code {#code}

### What does `Foo()` do if my `Foo` class has both `create()` and `apply()` methods? Does it call both? {#Foo()-create-apply}

Yes, it calls both. However perhaps not in the way you imagine. 

- `Foo` creates a new object instance using `create()`
- `()` is the `apply` call on the newly created `Foo` instance

This example program demonstrates what is going on:

```pony
use "debug"

class Foo
  new create() =>
    Debug("create called")
    
  fun apply() =>
    Debug("apply called")
    
actor Main
  new create(env: Env) =>
    Debug("call Foo()")
    Foo()
    
    Debug("call Foo")
    let foo = Foo
    
    Debug("call foo()")
    foo()
```

Check out [the example program in the [Pony Playground](https://playground.ponylang.org/?gist=26fce9986dd82a58f8bcd5197e22121f).

For more information see the [Sugar](https://tutorial.ponylang.org/expressions/sugar.html) section of the the tutorial.

## Compiling {#compiling}

### I get a "requires dynamic" error when compiling, how do I solve it? {#pic-compile-error}

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

As of Pony 0.17.0, if you are building `ponyc` from source, you can have `--pic` automatically set for you. When building `ponyc`, run the following `make` command and your generated `ponyc` binary will always supply `--pic` without you having to set it.

```bash
make default_pic=true
```

### How do I fix ponyc reporting "unable to link" along with "undefinded reference to SSL_"?

```bash
Linking ./stdlib
./stdlib.o(.text+0xd1474): error: undefined reference to 'EVP_MD_CTX_create'
./stdlib.o(.text+0xd1538): error: undefined reference to 'EVP_MD_CTX_cleanup'
./stdlib.o(.text+0xd15f4): error: undefined reference to 'EVP_MD_CTX_cleanup'
./stdlib.o(.text+0xd165b): error: undefined reference to 'EVP_MD_CTX_create'
./stdlib.o(.text+0xd1710): error: undefined reference to 'EVP_MD_CTX_cleanup'
./stdlib.o(.text+0xf7834): error: undefined reference to 'SSL_load_error_strings'
./stdlib.o(.text+0xf783b): error: undefined reference to 'SSL_library_init'
./stdlib.o(.text+0xf7842): error: undefined reference to 'CRYPTO_num_locks'
./stdlib.o(.text+0xf785a): error: undefined reference to 'CRYPTO_set_locking_callback'
./stdlib.o(.text+0xf7874): error: undefined reference to 'SSL_load_error_strings'
./stdlib.o(.text+0xf787b): error: undefined reference to 'SSL_library_init'
./stdlib.o(.text+0xf7882): error: undefined reference to 'CRYPTO_num_locks'
./stdlib.o(.text+0xf789a): error: undefined reference to 'CRYPTO_set_locking_callback'
./stdlib.o(.text+0x1006e2): error: undefined reference to 'EVP_MD_CTX_cleanup'
./stdlib.o(.text+0x10079d): error: undefined reference to 'EVP_MD_CTX_create'
./stdlib.o(.text+0x1007ed): error: undefined reference to 'EVP_MD_CTX_create'
./stdlib.o(.text+0x11cbd7): error: undefined reference to 'SSLv23_method'
./stdlib.o(.text+0x12542b): error: undefined reference to 'SSLv23_method'
./stdlib.o(.text+0x13536d): error: undefined reference to 'sk_pop'
./stdlib.o(.text+0x1356e5): error: undefined reference to 'sk_pop'
./stdlib.o(.text+0x1356fe): error: undefined reference to 'sk_free'
./stdlib.o(.text+0x1357ed): error: undefined reference to 'sk_pop'
./stdlib.o(.text+0x135b65): error: undefined reference to 'sk_pop'
./stdlib.o(.text+0x135b7e): error: undefined reference to 'sk_free'
./stdlib.o:stdlib:function stdlib_primitives_init: error: undefined reference to 'SSL_load_error_strings'
./stdlib.o:stdlib:function stdlib_primitives_init: error: undefined reference to 'SSL_library_init'
./stdlib.o:stdlib:function stdlib_primitives_init: error: undefined reference to 'CRYPTO_num_locks'
./stdlib.o:stdlib:function stdlib_primitives_init: error: undefined reference to 'CRYPTO_set_locking_callback'
./stdlib.o:stdlib:function main: error: undefined reference to 'SSL_load_error_strings'
./stdlib.o:stdlib:function main: error: undefined reference to 'SSL_library_init'
./stdlib.o:stdlib:function main: error: undefined reference to 'CRYPTO_num_locks'
./stdlib.o:stdlib:function main: error: undefined reference to 'CRYPTO_set_locking_callback'
collect2: error: ld returned 1 exit status
Warning: environment variable $CC undefined, using cc as the linker
Error:
unable to link: cc -o ./stdlib -O3 -march=native -mcx16 -latomic -fuse-ld=gold ./stdlib.o -L"/home/wink/prgs/pony/ponyc/build/release/" -Wl,-rpath,"/home/wink/prgs/pony/ponyc/build/release/" -L"/home/wink/prgs/pony/ponyc/build/release/../../packages" -Wl,-rpath,"/home/wink/prgs/pony/ponyc/build/release/../../packages" -L"/usr/local/lib" -Wl,-rpath,"/usr/local/lib" -Wl,--start-group -l"rt" -l"crypto" -l"pcre2-8" -l"ssl" -Wl,--end-group  -lpthread  -lponyrt-pic -ldl -lm -Wl,--export-dynamic-symbol=__PonyDescTablePtr -Wl,--export-dynamic-symbol=__PonyDescTableSize
```

This means your OS has openssl 1.1 installed, for example Arch Linux. When using the ponyc Makefile and targeting the tests that are using crypto or ssl add "OPENSSL=-Dopenssl_1.1.0" to the "make" command line:

```bash
make OPENSSL=-Dopenssl_1.1.0
```

When compiling with ponyc directly add "-Dopenssl_1.1.0" to the command line. For instance, to compile stdlib tests:

```bash
./build/release/ponyc -Dopenssl_1.1.0
```

## Ecosystem {#ecosystem}

### Does Pony have a package manager?

That would be yes and no. Package manager means different things to different people. What we have is a simple dependency manager called [pony-stable](https://github.com/ponylang/pony-stable) that we are planning on growing into a full featured tool. Whether that is a more full featured "dependency manager" or more full featured "package manager" depends on how you define the two terms.

## Linking {#linking}

### How can I supply custom linker parameters?

So, you need to link your program to a custom library or otherwise pass a particular linker option? You can accomplish your goal using the  `ponyc` `--linker` option.

You'll need to know what your current linker is. To get it, compile a pony program and pass `--verbose 3`.

#### On Linux, MacOS or other Unix-like

Then examine the output. You should see something like:

```bash
ld -execute -no_pie -dead_strip -arch x86_64 -macosx_version_min 10.8
  -o ./timer ./timer.o -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../lib"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../packages"
  -L"/usr/local/lib" -lponyrt -lSystem
```

The `ld` is the linker command that is usually used on MacOS or Linux. If I wanted to link in the library `Foo` and needed to pass `-lFoo` then I would compile my program as:

`ponyc --linker="ld -lFoo"`

That would change the linker command that `ponyc` runs to:

```bash
ld -lFoo -execute -no_pie -dead_strip -arch x86_64 -macosx_version_min 10.8
  -o ./timer ./timer.o -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../lib"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../packages"
  -L"/usr/local/lib" -lponyrt -lSystem
```

#### On Windows

Compiling a pony program with `--verbose 3` will produce something like:

```
cmd /C ""C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.11.25503\bin\HostX64\x64\link.exe"
  /DEBUG /NOLOGO /MACHINE:X64 /OUT:.\helloworld.exe .\helloworld.obj
  /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\ucrt\x64"
  /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\um\x64"
  /LIBPATH:"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.11.25503\lib\x64"
  /LIBPATH:"C:\pony\ponyc\build\release-llvm-3.9.1"
  /LIBPATH:"C:\pony\ponyc\build\release-llvm-3.9.1\..\..\packages"
  kernel32.lib msvcrt.lib Ws2_32.lib advapi32.lib vcruntime.lib legacy_stdio_definitions.lib dbghelp.lib ucrt.lib libponyrt.lib "
```

The path ending in `link.exe` is the linker that the pony compiler is currently using.

To add options to the link command, I would compile my program as something like:

`ponyc --linker="C:\OtherPath\link.exe /LIBPATH:C:\Foo"`

## Runtime {#runtime}

### Does Pony have green threads?

The short answer is no. Pony doesn't have green threads. By default, the Pony scheduler starts 1 "actor thread" per available CPU. These threads are used to schedule actors. Each of these threads is a kernel thread.

The longer answer is "it depends". Actors are Pony's unit of concurrency and many people when asking if Pony has green threads really are asking about how concurrency is modeled. You, as a Pony programmer, never interact with scheduler threads directly, you never interact with any sort of thread. You worry about actors and sending messages between them.
