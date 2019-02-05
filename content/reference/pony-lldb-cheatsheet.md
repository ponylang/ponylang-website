+++
title = "Pony LLDB Cheatsheet"
+++

## Setup

### macOS Setup

```bash
% brew install llvm@3.9
% sudo /usr/sbin/DevToolsSecurity --enable
```

## Basics

### Official LLDB tutorial

[http://lldb.llvm.org/tutorial.html](http://lldb.llvm.org/tutorial.html)

### GDB <--> LLDB Rosetta Stone

[http://lldb.llvm.org/lldb-gdb.html](http://lldb.llvm.org/lldb-gdb.html)

### Building a Debuggable Executable

```bash
% ponyc --debug
```

### Running an Executable

```bash
% lldb EXECUTABLE -- arg1 arg2 arg3 …
% lldb -- EXECUTABLE arg1 arg2 arg3 ...
(lldb) run
```

### Setting Breakpoints

```bash
(lldb) breakpoint set --file foo.c --line 12
(lldb) breakpoint set --name foo 
(lldb) b foo.c:12
(lldb) b Main_create
(lldb) b map.pony:73
```

When using a file name/line combination to set the breakpoint, you can specify any file in the program without having to specify a path to that file, as long as the file name is unambiguous.

### List Breakpoints

```bash
(lldb) breakpoint list
(lldb) b
```

### Backtrace

```bash
(lldb) thread backtrace
(lldb) bt
```

If you would like to limit the size of the backtrace (for example, when you are debugging a case of runaway recursion that blows out the stack and generates a very long backtrace), you can use the `--count` or `-c` option to specify the number of frames to print, starting with the most recent one.

```bash
(lldb) thread backtrace --count 5
(lldb) bt -c 5
```

### Stepping

```bash
(lldb) thread step-in
(lldb) s
(lldb) sif funToStepInto
(lldb) thread step-over
(lldb) n
(lldb) thread step-out
(lldb) finish
(lldb) thread until LINE
```

### Frame

Select a frame:

```bash
(lldb) frame select NUMBER
(lldb) f NUMBER
```

Show the variables in the current frame:

```bash
(lldb) frame variable
```

Show a specific variable from the current frame:

```bash
(lldb) frame variable VARIABLE
(lldb) p VARIABLE
```

Pointer, array, structure, and cast operation from C can be applied to frame variables.

&variable
: address of a variable

*variable
: dereference a pointer

variable.field
: access a field within a structure

pointer_variable->field
: access a field within a structure pointed to by a pointer

array_pointer[index]
: access an index within an array

(type_t *)variable
: cast variable to a pointer to a type_t

## Examples

###  Example: Examining an object

```bash
(lldb) frame variable
(OscMessage *const) this = <variable not available>
(Array_U8_val *) parts = 0x0000000108fcf4c0
(OscString *) oscAddress = <variable not available>
(OscString *) types = 0x00007fff5fbff878
(lldb) frame variable *types
(OscString) *types = {
  _data = 0x0000000108fcf560
}
(lldb) frame variable *types->_data
(String) *types->_data = (_size = 2, _alloc = 3, _ptr = ",f")

(ponytest_TestHelper *) this = 0x0000000110ff5020
(lldb) p this
(ponytest_TestHelper *) $2 = 0x0000000110ff5020
(lldb) p *$2
(ponytest_TestHelper) $3 = {
  _runner = 0x0000000110ff7200
  env = 0x0000000108ffec00
}
(lldb) p $3.env
(Env *) $4 = 0x0000000108ffec00
(lldb) p *$4
(Env) $5 = {
  root = 0x000000010004f3e0
  input = 0x0000000108fd6800
  out = 0x0000000108fff500
  err = 0x0000000108fff600
  args = 0x0000000108fd6400
  _envp = 0x00007fff5fbffa98
  _vars = 0x000000010004f3b0
}
```

Using `p` lets you work from the resulting lldb temporary variables, which can be very convenient when you want to examine an intermediate result.

### Example: Printing A String

Assume you have a Pony String called `x`. You can print the string like this:

```bash
(lldb) p (char *)(x->_ptr)
(char *) $3 = 0x00000001000106f8 "abc"
(lldb)
```

### Example: Printing The Values In An Array Of Numbers

Assume you have an `Array[U64]` called `x` with 6 elements. You can print the values of the values of the elements like this:

```bash
(lldb) p *(long(*)[6])(x->_ptr)
(long [6]) $3 = ([0] = 1, [1] = 2, [2] = 3, [3] = 4, [4] = 5, [5] = 6)
```

You can adjust the type (`long`) to appropriately print the types that correspond to the array values, and adjust the size (`6`) to print more or fewer of the elements.

## Pony Stuff

### Method Name Mangling

{{< warning title="Future breakage possible!" >}}
While currently necessary for some debugging, you should know that name mangling might change in the future. Do not depend on this remaining static. 
{{< /warning >}}

Method names get mangled by the compiler. The general format for the mangling is:

`<package_>type<_typearg1_typearg2>_rcap_methodname_mangling`

In the above:

package
: the name of the package (for methods brought in through use expressions)

type
: the name of the type to which the method belongs

typearg1, typearg2 …
: the type parameters of the method (for methods that use type parameters)

rcap
: the reference capability of the method

methodname
: the name of the method

mangling
: a mangling string where each character indicates the type of each method parameter and the method’s return type according to the following conversion:

Type | Mangling
---|---
object | o
Bool   | b
I8 | c
I16 | s
I32 | i
I64 | w
I128 | q
ILong | l
ISize | z
U8 | C
U16 | S
U32 | I
U64 | W
U128 | Q
ULong | L
USize | Z
F32 | f
F64 | d

These rules can be used to determine the name of function in order to specify that you would like to place a breakpoint on it. You can also type `b <characters><tab>` to see a tab-complete list of all the available functions that start with `<characters>`. To set a breakpoint on a function:

```bash
(lldb) breakpoint set --name Bar_foo
(lldb) b Bar_foo
```

### Calling Methods

As of April 5, 2017, [issue #1813](https://github.com/ponylang/ponyc/issues/1813) is preventing this from working.

### Behaviors and Messages

Each behavior has an associated send method (<mangled_behavior_function_name>__send) that is used to send a message to the receiver to trigger that behavior. Each actor has a dispatch method (<actor>_Dispatch) that translates messages into calls to the appropriate functions in the receiver.
