# Testing

Pony ships two testing packages in its standard library: PonyTest for unit testing and PonyCheck for property-based testing. Both run inside the same test harness.

## Unit Testing

[PonyTest](https://stdlib.ponylang.io/pony_test--index/) is Pony's unit testing framework. Each test is a class that implements `UnitTest`. You provide a `name()` and an `apply(h: TestHelper)` function that contains your assertions.

```pony
use "pony_test"

class iso _TestAdd is UnitTest
  fun name(): String => "addition"

  fun apply(h: TestHelper) =>
    h.assert_eq[U32](4, 2 + 2)
```

`TestHelper` provides assertion functions like `assert_eq`, `assert_true`, `assert_error`, and others. By default, log messages only appear for failing tests.

Tests can optionally define `set_up(h: TestHelper)?` and `tear_down(h: TestHelper)` for environment setup and cleanup. `set_up` runs before the test; `tear_down` runs after, regardless of pass or fail. See the [PonyTest stdlib docs](https://stdlib.ponylang.io/pony_test--index/) for the full API.

## Property-Based Testing

[PonyCheck](https://stdlib.ponylang.io/pony_check--index/) is Pony's property-based testing library. Instead of specifying individual examples, you define a property that should hold for all inputs and let PonyCheck generate random test data. This is effective at finding edge cases you wouldn't write by hand.

A property test implements `Property1`. You provide a `name()`, a `gen()` that returns a `Generator` for your input type, and a `property()` function that asserts the property.

```pony
use "collections"
use "pony_check"

class iso _ListReverseProperty is Property1[List[USize]]
  fun name(): String => "list/reverse"

  fun gen(): Generator[List[USize]] =>
    Generators.list_of[USize](Generators.usize())

  fun property(arg1: List[USize], ph: PropertyHelper) =>
    ph.assert_array_eq[USize](arg1, arg1.reverse().reverse())
```

When a property fails, PonyCheck shrinks the failing input to find the smallest counterexample, making failures easier to diagnose.

You can also run properties inline within a `UnitTest` using `PonyCheck.for_all`:

```pony
use "collections"
use "pony_check"
use "pony_test"

class iso _TestListReverse is UnitTest
  fun name(): String => "list/reverse/inline"

  fun apply(h: TestHelper) =>
    let gen = recover val Generators.list_of[USize](Generators.usize()) end
    PonyCheck.for_all[List[USize]](gen, h)(
      {(sample, ph) =>
        ph.assert_array_eq[USize](sample, sample.reverse().reverse())
      })
```

See the [PonyCheck stdlib docs](https://stdlib.ponylang.io/pony_check--index/) for the full set of generators and configuration options.

## Testing Async Code

Pony tests run concurrently by default, but a simple test completes when `apply` returns. For tests that involve actors, you need the test to stay alive until async work finishes.

Call `h.long_test(timeout)` to indicate the test should not complete when `apply` returns. The timeout (in nanoseconds) acts as a safety net for hung tests. When your async work finishes, call `h.complete(success)` to signal completion.

For tests with multiple independent async operations, use actions. Call `h.expect_action("name")` for each operation you're waiting on, then `h.complete_action("name")` as each one finishes. The test completes automatically when all expected actions are done.

Tests that create TCP listeners, connections, timers, or other I/O resources must clean them up. Call `h.dispose_when_done(actor)` to register actors for disposal when the test finishes. Without this, the test program will hang after all tests pass because the runtime won't exit while actors hold live I/O resources.

## Test Project Structure

Pony projects use a single top-level `_test.pony` whose `Main` actor orchestrates all tests. Each subpackage has its own `_test.pony` with a `Main is TestList` actor that provides two constructors:

- `create(env: Env)` — for running the subpackage's tests directly
- `make()` — for aggregation into the top-level runner

The top-level `_test.pony` imports subpackages via aliased `use` statements and delegates to their test lists:

```pony
use "pony_test"
use foo = "foo"
use bar = "bar"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    foo.Main.make().tests(test)
    bar.Main.make().tests(test)
```

Only the top-level package gets compiled and run. The `ponyc/packages/stdlib/` directory in the Pony compiler source is a good example of this pattern in practice.

## Coverage Reports

Pony supports generating test coverage reports through LLVM's source-based code coverage tooling. See [Coverage Reports](testing/coverage-reports.md) for setup instructions.
