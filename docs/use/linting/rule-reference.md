# Rule Reference

Each rule is listed with its default status, a description of what it checks, and examples of incorrect and correct code.

## `style/acronym-casing`

**Default:** on

Known acronyms in type names must be fully uppercased. The recognized acronyms are: API, AST, CSS, DNS, FFI, FIFO, HTML, HTTP, IMAP, JSON, MIME, SMTP, SSH, SSL, TCP, TLS, UDP, URI, URL, UUID, XML.

**Incorrect:**

```pony
class JsonParser

primitive HttpMethod
```

**Correct:**

```pony
class JSONParser

primitive HTTPMethod
```

## `style/blank-lines`

**Default:** on

Blank line conventions within and between entities.

Within entities:

- No blank line between the entity declaration and the first body content (docstring or first member).
- No blank lines between consecutive fields.
- Exactly one blank line before each method. Exception: when both the preceding method and the current method are one-liners, zero blank lines are also allowed.

Between entities:

- Exactly one blank line between consecutive entities. Exception: when both entities are one-liners, zero blank lines are also allowed.

**Incorrect:**

```pony
class Foo

  let x: U32 = 0

  let y: U32 = 1

  fun apply(): U32 => x + y
```

**Correct:**

```pony
class Foo
  let x: U32 = 0
  let y: U32 = 1

  fun apply(): U32 => x + y
```

## `style/comment-spacing`

**Default:** on

Line comments (`//`) must be followed by exactly one space. An empty comment (`//` with nothing after it) is also acceptable. This rule does not apply inside string literals, including triple-quoted strings.

**Incorrect:**

```pony
//This comment has no space
//  This comment has two spaces
```

**Correct:**

```pony
// This comment has one space
//
// Empty comment above is fine
let url = "http://example.com" // inside strings is ignored
```

## `style/docstring-format`

**Default:** on

Docstring `"""` delimiters must each be on their own line. Single-line docstrings like `"""text"""` are flagged. Types and methods annotated with `\nodoc\` are exempt, as are methods inside `\nodoc\`-annotated entities.

**Incorrect:**

```pony
class Foo
  """Foo docstring."""

  fun bar(): None =>
    """Bar docstring."""
    None
```

**Correct:**

```pony
class Foo
  """
  Foo docstring.
  """

  fun bar(): None =>
    """
    Bar docstring.
    """
    None
```

## `style/dot-spacing`

**Default:** on

`.` must have no spaces around it. `.>` must be spaced as an infix operator with spaces on both sides. Both operators skip the "before" check on continuation lines where the operator is the first non-whitespace character.

**Incorrect:**

```pony
let x = foo .bar
let y = foo. bar
let z = foo.>bar
```

**Correct:**

```pony
let x = foo.bar
let y = foo .> bar

// Continuation lines are fine
let z = foo
  .bar
  .> baz
```

## `style/file-naming`

**Default:** on

The file name must match the principal type defined in the file, converted to snake_case. The principal type is determined by a heuristic: if the file contains a single entity, that entity is principal. If a trait or interface is present alongside other types, the trait or interface is principal. Files with multiple unrelated types (no clear principal) are not checked. Private types preserve their leading underscore in the filename.

Files named `_test.pony` that contain a `Main` actor are exempt (standard test runner convention).

**Incorrect:**

```pony
// File: parser.pony
class FooParser
  // Error: expected file name foo_parser.pony
```

**Correct:**

```pony
// File: foo_parser.pony
class FooParser

// File: _private_helper.pony
class _PrivateHelper

// File: runnable.pony
trait Runnable
class Runner // trait is principal, so runnable.pony is correct
```

## `style/hard-tabs`

**Default:** on

Tab characters are not allowed anywhere in source files. Pony uses spaces for indentation.

A violation is a literal tab character in the source. Since tabs are invisible in rendered text, a tab-indented line looks like a space-indented line but triggers this rule. Editors should be configured to insert spaces instead of tabs.

**Correct:**

```pony
actor Main
  new create(env: Env) =>
    env.out.print("spaces, not tabs")
```

## `style/indentation-size`

**Default:** on

Leading-space indentation must be a multiple of 2. Lines inside triple-quoted strings, blank lines, lines with zero indentation, and tab-indented lines are not checked. Tab indentation is handled by `style/hard-tabs`.

**Incorrect:**

```pony
class Foo
  fun apply(): None =>
   let x = 1
     let y = 2
       None
```

**Correct:**

```pony
class Foo
  fun apply(): None =>
    let x = 1
    let y = 2
    None
```

## `style/line-length`

**Default:** on

Lines must not exceed 80 codepoints. Multi-byte UTF-8 characters count as one codepoint each. A line of exactly 80 codepoints is acceptable; 81 or more triggers a violation.

**Incorrect:**

```pony
// The following line is too long
let description = "This string is far too long to fit within the eighty codepoint limit for lines"
```

**Correct:**

```pony
let description =
  "This string has been split" +
  " across multiple lines"
```

## `style/match-case-indent`

**Default:** on

The `|` introducing each match case must align with the `match` keyword's column. This makes the match structure visually clear regardless of nesting depth. Inline continuation pipes (e.g., `| "a" | "b"`) are not checked since only the leading `|` on each line needs alignment.

**Incorrect:**

```pony
match x
  | let s: String => s
  | let n: U32 => n.string()
end
```

**Correct:**

```pony
match x
| let s: String => s
| let n: U32 => n.string()
end
```

## `style/match-no-single-line`

**Default:** on

Match expressions must span multiple lines. A single-line match is harder to scan and usually indicates the expression would be clearer as an `if`/`else` chain.

**Incorrect:**

```pony
let y = match x | let s: String => s else "" end
```

**Correct:**

```pony
let y =
  match x
  | let s: String => s
  else
    ""
  end
```

## `style/member-naming`

**Default:** on

Fields, methods, parameters, and local variables must use snake_case. Names may start with a leading underscore for private visibility. The discard pattern `_` by itself is not checked. Trailing primes (e.g., `value'`) are permitted.

**Incorrect:**

```pony
class Foo
  let myField: U32 = 0
  var someValue: String = ""

  fun doSomething(): None =>
    let myVar: U32 = 1
    None
```

**Correct:**

```pony
class Foo
  let my_field: U32 = 0
  var _some_value: String = ""

  fun do_something(): None =>
    let my_var: U32 = 1
    None
```

## `style/package-naming`

**Default:** off

The package directory name must be snake_case, containing only lowercase letters, digits, and underscores. This rule is off by default because application packages often use hyphens to match CLI naming conventions.

**Incorrect (if enabled):**

```text
MyPackage/
  main.pony

my-package/
  main.pony
```

**Correct:**

```text
my_package/
  main.pony
```

## `style/package-docstring`

**Default:** on

Each package should have a file named after the package (e.g., `my_package.pony` for a package in the `my_package/` directory) containing a package-level docstring as the first expression. Directory names with hyphens are normalized to underscores (e.g., `pony-lint/` expects `pony_lint.pony`).

**Incorrect:**

```text
my_package/
  main.pony         # no my_package.pony file
```

```pony
// File: my_package/my_package.pony
use "collections"   # no docstring before the first use statement
```

**Correct:**

```pony
// File: my_package/my_package.pony
"""
Provides utilities for working with packages.
"""

use "collections"
```

## `style/partial-call-spacing`

**Default:** on

The `?` at partial call sites must immediately follow `)` with no space. This is the opposite convention from method declarations.

**Incorrect:**

```pony
let x = foo() ?
let y = bar(1, 2) ?
```

**Correct:**

```pony
let x = foo()?
let y = bar(1, 2)?
```

## `style/partial-spacing`

**Default:** on

The `?` in partial method declarations must have surrounding spaces. A space is required before `?` and a space or end-of-line after it.

**Incorrect:**

```pony
class Foo
  fun bar()? => None
```

**Correct:**

```pony
class Foo
  fun bar() ? => None
```

## `style/prefer-chaining`

**Default:** on

Flags patterns where a value is bound to a local variable and methods are called on it repeatedly — when `.>` chaining would be cleaner. Triggers on both `let` and `var` bindings with 2 or more consecutive dot-calls, whether or not the variable is returned after the calls.

**Incorrect:**

```pony
class Foo
  fun make_list(): Array[U32] =>
    let r = Array[U32]
    r.push(1)
    r.push(2)
    r.push(3)
    r
```

**Correct:**

```pony
class Foo
  fun make_list(): Array[U32] =>
    Array[U32]
      .> push(1)
      .> push(2)
      .> push(3)
```

**Also incorrect:**

```pony
class Foo
  fun apply(): None =>
    let x = Bar
    x.baz(1)
    x.qux(2)
```

**Correct:**

```pony
class Foo
  fun apply(): None =>
    Bar .> baz(1) .> qux(2)
```

## `style/public-docstring`

**Default:** on

Public types and public methods must have a docstring. A type or method is public if its name does not start with `_`.

Several exemptions apply. No docstring is required for:

- Types or methods annotated with `\nodoc\`
- Methods inside private types or `\nodoc\`-annotated types
- `Main` actors
- Well-known method names: `create`, `string`, `eq`, `ne`, `hash`, `hash64`, `compare`, `lt`, `le`, `ge`, `gt`, `dispose`, `has_next`, `next`, `values`, `size`
- Type aliases (Pony does not support docstrings on type aliases)
- Methods inside anonymous `object` literals
- Concrete methods with 3 or fewer top-level expressions in the body (abstract methods are not exempt)

**Incorrect:**

```pony
class Foo
  fun my_method(a: U32, b: U32, c: U32, d: U32): U32 =>
    let x = a + b
    let y = c + d
    let z = x * y
    z + 1
```

**Correct:**

```pony
class Foo
  """A class that does arithmetic."""

  fun my_method(a: U32, b: U32, c: U32, d: U32): U32 =>
    """Combine four values through addition and multiplication."""
    let x = a + b
    let y = c + d
    let z = x * y
    z + 1

  fun apply(): U32 =>
    // Exempt: 3 or fewer expressions
    let x: U32 = 1
    let y: U32 = 2
    x + y
```

## `style/trailing-whitespace`

**Default:** on

Lines must not have trailing spaces or tabs. Completely empty lines (zero length) are not flagged.

Because trailing whitespace is invisible in rendered text, violations are not visible in code examples. A violation is one or more space or tab characters between the last visible character on a line and the line ending.

**Correct:**

```pony
class Foo
  fun apply(): None =>
    let x = 1
    None
```

## `style/type-naming`

**Default:** on

Type names must use CamelCase. Names may start with a leading underscore for private visibility. After the optional leading underscore, the name must begin with an uppercase letter and contain only letters and digits. Underscores within the name are not allowed. Trailing primes are permitted.

**Incorrect:**

```pony
class foo_parser

primitive my_helper

actor some_actor
```

**Correct:**

```pony
class FooParser

primitive _MyHelper

actor SomeActor
```
