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

## `style/array-literal-format`

**Default:** on

Checks formatting of multiline array literals. For array literals that span multiple lines:

- The opening `[` must be the first non-whitespace on its line (no hanging indent after `=` or other expression context).
- A space is required after `[` when there is content on the same line.

Single-line array literals are not checked.

**Incorrect:**

```pony
actor Main
  new create(env: Env) =>
    let ns = [as USize:
      1
      2
    ]
```

**Correct:**

```pony
actor Main
  new create(env: Env) =>
    let ns =
      [ as USize:
        1
        2 ]
```

The closing `]` may also be on its own line:

```pony
actor Main
  new create(env: Env) =>
    let ns =
      [ as USize:
        1
        2
      ]
```

## `style/assignment-indent`

**Default:** on

When an assignment's right-hand side spans multiple lines, the RHS must start on the line after the `=`, not on the same line. Single-line assignments are not checked.

**Incorrect:**

```pony
class Foo
  fun apply(x: U32): U32 =>
    var y: U32 = if x > 0 then
      x
    else
      U32(0)
    end
    y
```

**Correct:**

```pony
class Foo
  fun apply(x: U32): U32 =>
    var y: U32 =
      if x > 0 then
        x
      else
        U32(0)
      end
    y
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

## `style/call-argument-format`

**Default:** on

Checks formatting of multiline function call arguments. For calls with two or more positional arguments that span multiple lines:

- No arguments start on the `(` line — arguments should begin on the next line.
- Arguments are either all on one continuation line, or each on its own line.

Single-line calls, single-argument calls, and named-argument-only calls are not checked. The `where` clause is allowed on its own line and is not subject to layout checks. These rules apply to both regular calls and FFI calls.

**Incorrect:**

```pony
// Arguments start on the ( line
foo.bar(U32(1),
  U32(2), U32(3))
```

```pony
// Mixed layout — some args share a line, others don't
foo.bar(
  U32(1), U32(2),
  U32(3))
```

**Correct:**

```pony
// Single-line — not checked
foo.bar(U32(1), U32(2), U32(3))
```

```pony
// All on one continuation line
foo.bar(
  U32(1), U32(2), U32(3))
```

```pony
// Each on its own line
foo.bar(
  U32(1),
  U32(2),
  U32(3))
```

```pony
// Where clause on its own line
foo.bar(
  U32(1),
  U32(2)
  where y = U32(3))
```

```pony
// FFI call — same rules
@pony_os_errno(
  U32(1),
  U32(2))
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

## `style/control-structure-alignment`

**Default:** on

Control structure keywords must be vertically aligned. Each keyword in a control structure must start at the same column as the opening keyword. Single-line structures are exempt. The `do` keyword is not checked because it always appears on the same line as its opening keyword.

The following keyword groups are checked:

- `if` / `elseif` / `else` / `end`
- `ifdef` / `elseif` / `else` / `end`
- `while` / `else` / `end`
- `for` / `else` / `end`
- `try` / `else` / `then` / `end`
- `repeat` / `until` / `else` / `end`
- `with` / `end`

**Incorrect:**

```pony
if condition then
  do_something()
    else
  do_other()
      end
```

**Correct:**

```pony
if condition then
  do_something()
else
  do_other()
end
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

## `style/lambda-spacing`

**Default:** on

Checks whitespace inside lambda braces per the style guide. Lambda expressions must have no space after `{`; a space before `}` is required only on single-line lambdas. Lambda types must have no space on either side (`{` or `}`). Bare lambdas (`@{`) follow the same rules.

**Incorrect:**

```pony
// Space after {
{ (a: USize, b: USize): USize => a + b }

// No space before } on single-line
{(a: USize, b: USize): USize => a + b}

// Space before } on multi-line
{(a: USize, b: USize): USize =>
  a + b }

// Space inside lambda type braces
type Foo is { (USize, USize): USize } box
```

**Correct:**

```pony
// Single-line: no space after {, space before }
{(a: USize, b: USize): USize => a + b }

// Multi-line: no space after {, } on its own line
{(a: USize, b: USize): USize =>
  a + b
}

// Lambda type: no space on either side
type Foo is {(USize, USize): USize} box

// Bare lambda: same rules
@{(a: USize, b: USize): USize => a + b }
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

## `style/method-declaration-format`

**Default:** on

Checks formatting of multiline method declarations. When a method's parameters span multiple lines, each parameter must be on its own line. When a method declaration spans multiple lines, the return type `:` must be indented one level (2 spaces) from the method keyword, and the `=>` must align with the method keyword. Single-line declarations are not checked.

Applies to `fun`, `new`, and `be` declarations.

**Incorrect:**

```pony
class Foo
  fun find(
    value: U32, offset: USize)
    : USize
  =>
    offset
```

Two parameters share a line.

```pony
class Foo
  fun find(
    value: U32,
    offset: USize)
      : USize
  =>
    offset
```

The `:` is indented too far — it should be at the method keyword's column + 2.

```pony
class Foo
  fun find(
    value: U32,
    offset: USize)
    : USize
    =>
    offset
```

The `=>` is indented too far — it should align with `fun`.

**Correct:**

```pony
class Foo
  fun find(
    value: U32,
    offset: USize)
    : USize
  =>
    offset
```

```pony
// Constructor
class Foo
  let _x: U32
  let _y: U32

  new create(
    x: U32,
    y: U32)
  =>
    _x = x
    _y = y
```

```pony
// Behavior
actor Foo
  be apply(
    x: U32,
    y: U32)
  =>
    None
```

## `style/operator-spacing`

**Default:** on

Checks whitespace around operators per the style guide. Binary operators require a space before and after. The `not` keyword requires a space after; before `not`, either a space or a non-alphanumeric character (e.g., `(`) is acceptable. Unary minus must NOT have a space after the `-`. The "before" check is skipped on continuation lines where the operator is the first non-whitespace character.

**Incorrect:**

```pony
let x = 1+2
let y = a ==b
if not(x) then -a end
let z = - a
```

**Correct:**

```pony
let x = 1 + 2
let y = a == b
if not x then -a end

// Continuation lines are fine
let z =
  + a
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

Flags patterns where a value is bound to a local variable and methods are called on it — when `.>` chaining would be cleaner. Triggers on both `let` and `var` bindings. Fires with 2 or more consecutive dot-calls (whether or not the variable is returned), or with a single call followed by a bare reference to return the variable.

**Incorrect** — multiple calls with trailing reference:

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

**Incorrect** — single call with trailing reference:

```pony
class Foo
  fun make_set(): Set[String] =>
    let s = Set[String]
    s.set("foo")
    s
```

**Correct:**

```pony
class Foo
  fun make_set(): Set[String] =>
    Set[String] .> set("foo")
```

**Also incorrect** — multiple calls without trailing reference:

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

## `style/type-alias-format`

**Default:** on

Checks formatting of multiline type alias declarations. For type aliases with a multiline union or intersection type:

- The opening `(` must be the first non-whitespace on its line (no hanging indent after `is`).
- A space is required after `(`.
- For each `|` or `&` that is the first non-whitespace on its line, a space is required after it.
- A space is required before the closing `)`.

Single-line type aliases and simple aliases (no union/intersection) are not checked. Only `|`/`&` at line starts (first non-whitespace) are checked — mid-line separators in nested types are not.

**Incorrect:**

```pony
// Hanging indent — ( must be on its own line
type Signed is (I8
  | I16
  | I32 )

// Missing space after (
type Signed is
  (I8
  | I16
  | I32 )

// Missing space after |
type Signed is
  ( I8
  |I16
  | I32 )

// Missing space before )
type Signed is
  ( I8
  | I16
  | I32)
```

**Correct:**

```pony
// Single-line — not checked
type Signed is (I8 | I16 | I32)

// Multiline with ) inline
type Signed is
  ( I8
  | I16
  | I32 )

// Multiline with ) on its own line
type Signed is
  ( I8
  | I16
  | I32
  )

// Intersection type
type Both is
  ( Hashable
  & Stringable )
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

## `style/type-parameter-format`

**Default:** on

Checks formatting of multiline type parameter lists. The opening `[` must always be on the same line as the entity or method name. When type parameters span multiple lines, each type parameter must be on its own line. For entities with a provides clause (`is`), the `is` keyword must be indented one level (2 spaces) from the entity keyword when it appears on its own line. Single-line type parameter lists are not checked (except for the `[` same-line requirement, which always applies).

Applies to entities (`class`, `actor`, `primitive`, `struct`, `trait`, `interface`, `type`) and methods (`fun`, `new`, `be`).

**Incorrect:**

```pony
class Foo
  [A, B]
```

The `[` is on a different line than the name.

```pony
class Foo[
  A, B,
  C]
```

Two type parameters share a line.

```pony
interface Hashable

class Foo[
  A,
  B]
    is Hashable
```

The `is` keyword is indented too far — it should be at the entity keyword's column + 2.

**Correct:**

```pony
// Single-line — not checked
class Foo[A, B]
```

```pony
// Multiline class
class Foo[
  A,
  B]
```

```pony
// Entity with provides clause
interface Hashable

trait Foo[
  A,
  B]
  is Hashable
```

```pony
// Method type parameters
class Foo
  fun bar[
    A,
    B](x: A)
  =>
    None
```
