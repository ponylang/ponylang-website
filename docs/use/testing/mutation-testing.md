# Mutation Testing

Mutation testing measures how well your tests detect real bugs. The compiler instruments your program by inserting small changes — mutants — into the compiled code. Each mutant replaces one operator or value with a variant: `+` becomes `-`, `==` becomes `!=`, a constant changes. Your tests run once per mutant. If a test fails, the mutant is killed; if every test passes, the mutant survived.

## Quick Start

Compile with `--mutate` and run `pony-mutate` against the resulting binary:

```bash
ponyc --mutate -b myapp .
pony-mutate ./myapp
```

The compiler writes a `.mutants.json` file alongside the binary, listing every instrumented site. `pony-mutate` reads that file, runs a baseline (unmutated) pass, then activates each mutant in turn and reports which survived.

## Compiler Flags

`--mutate`
: Instrument the program for mutation testing. Without this flag, no mutants are generated.

`--mutate-operators=CATEGORIES`
: Comma-separated list of mutation categories to instrument. Default: all. Example: `--mutate-operators=aor,ror`.

`--mutate-scope=FILE[:LINE[-LINE]]`
: Restrict instrumentation to a source file, optionally to a line range. Repeatable. A scope also matches directories: `--mutate-scope=src/parser` instruments every file under `src/parser/`, subdirectories included, by matching on `/` boundaries in the source path. Examples: `--mutate-scope=src/parser.pony`, `--mutate-scope=src/parser.pony:30-80`, `--mutate-scope=src/parser.pony:42`.

## Mutation Categories

| Category | Name | What it does |
|----------|------|--------------|
| `aor` | Arithmetic operator replacement | Replaces `+` with `-`, `*` with `/`, etc. |
| `bor` | Boolean operator replacement | Swaps `and`, `or`, and `xor` with each other |
| `ror` | Relational operator replacement | Replaces `==` with `!=`, `<` with `>=`, etc. |
| `sor` | Shift operator replacement | Replaces `<<` with `>>` and vice versa |
| `uoi` | Unary operator insertion | Inserts a unary negation or bitwise complement |
| `cr` | Constant replacement | Changes numeric and character literals in source code |
| `rvr` | Return value replacement | Replaces a return value with a default (e.g., `String` returns become empty) |
| `vcr` | Void call removal | Removes calls to methods that return `None` |
| `amr` | Arithmetic mode replacement | Swaps the safe and unsafe forms of integer division (`/`), integer remainder (`%`), left shift (`<<`), and right shift (`>>`) |

Categories other than `cr` skip operators whose operands are all compile-time constants. `cr` replaces literals written in source, not values the compiler derives from them.

Instrumentation happens during code generation, so only methods reachable from `Main` produce mutants. A scoped file whose code the test binary never calls produces no mutants at all — it won't show up as "no coverage" either, since there is no mutant to report.

## Controlling Mutation in Source

Three annotations control which categories apply to a type or method. Each can appear on a concrete type (actor, class, struct, or primitive) or on a method with a body. A declaration can have at most one mutation annotation.

`\nomutate\`
: Suppress all mutation. On a type, excludes every method. On a method, excludes that method.

`\mutate_only(cat1, cat2, ...)\`
: Instrument only the listed categories. Everything else is excluded.

`\mutate_except(cat1, cat2, ...)\`
: Exclude the listed categories from mutation.

Category names are the same short strings used by `--mutate-operators` (`aor`, `ror`, `cr`, etc.). The compiler rejects unknown category names even in builds without `--mutate`.

```pony
class \nomutate\ Ledger
  fun balance(): U64 => 100

  fun \mutate_only(aor, ror)\ affordable(balance': U64, charge: U64): Bool =>
    (balance'.i128() - charge.i128()) > 0

class MyClass
  fun \mutate_except(cr)\ real_work(): U32 => 1 + 2
```

`Ledger` suppresses mutation by default. Its `affordable` method opts back in for arithmetic and relational operators only. On `MyClass.real_work`, `mutate_except(cr)` excludes constant replacement from the selected categories.

### Type-Level Limits

A type-level `mutate_only(...)` or `mutate_except(...)` sets a hard limit for every method inside. The compiler rejects a method's `mutate_only(...)` if it requests a category outside the type's limit — even in non-mutation builds, so you catch the conflict early. A method-level `mutate_except(...)` can narrow the type's selection further.

With type-level `\nomutate\`, methods start excluded but can opt in with `\mutate_only(...)\`.

### Trait and Interface Defaults

When a trait or interface supplies a default method body, the annotation on that body travels with it into implementing types. If a trait method has `\mutate_only(ror)\`, every type that inherits that body gets `ror`-only instrumentation for it, regardless of the type's own annotation. The receiving type's annotation still applies to parameter defaults in a bodyless signature.

A concrete type can override an inherited body with its own method and annotation.

### Interaction with Command-Line Filters

Source annotations and `--mutate-operators` intersect: a site is instrumented only if the category is allowed by both the annotation and the command-line filter. `--mutate-scope` applies on top of that.

## Running pony-mutate

```bash
pony-mutate [options] <binary> [-- extra-args...]
```

`pony-mutate` is installed alongside `ponyc`. It reads the `.mutants.json` file that the compiler wrote next to the binary, runs a baseline pass to confirm tests pass without mutation, then runs each mutant by setting the `PONY_MUTANT_ID` environment variable before executing the binary.

Mutant IDs are assigned in code-generation order, so adding a test or changing the code can renumber them. An ID is only meaningful for the binary and `.mutants.json` it came from.

### Options

`-j WORKERS`
: Number of parallel worker processes. Default: number of CPU cores.

`--timeout=N`
: Timeout multiplier relative to baseline run time. A mutant that takes longer than N times the baseline is killed as a timeout. Default: 10. Set to 0 to disable.

`--no-baseline`
: Skip the baseline run. Useful when you've already confirmed tests pass.

`--operators=CATEGORIES`
: Comma-separated mutation categories to run. Filters the mutants loaded from the info file.

`--scope=FILE[:LINE[-LINE]]`
: Filter mutants to a specific source file path, optionally to a single line or a line range. Uses the same format as the compiler's `--mutate-scope`.

`--format=FORMAT`
: Report format: `terminal` (default) or `json` (Stryker JSON).

`--json-file=PATH`
: Write a Stryker JSON report to this file alongside the terminal report.

`--test-maxthreads=N`
: Pass `--ponymaxthreads=N` to the test binary. Default: 1. Set to 0 to omit the flag.

`--test-noscale`
: Pass `--ponynoscale` to the test binary. On by default.

Arguments after `--` are passed through to the test binary.

### pony_test Suites

`pony_test` saves failing property counterexamples to a regression directory and replays them on the next run. Under `pony-mutate`, a counterexample saved while one mutant is active gets replayed against the next mutant. Set `PONYTEST_NO_DB=1` to turn that off:

```bash
PONYTEST_NO_DB=1 pony-mutate ./myapp
```

## Reading Results

`pony-mutate` reports each mutant as one of:

- **Killed** — the test binary exited with a nonzero status or terminated due to a signal.
- **Survived** — the test binary exited successfully with this mutant active.
- **Timed out** — the test binary exceeded the timeout. Treated as killed, since the mutation changed observable behavior.
- **No coverage** — baseline coverage recorded no execution of the mutated code path.

The mutation score is `(killed + timed out) / tested`, where `tested` excludes mutants with no coverage.

## Exit Codes

`pony-mutate` exits with distinct codes so scripts can distinguish outcomes:

| Code | Meaning |
|------|---------|
| 0 | All mutants were killed (or none to run) |
| 1 | One or more mutants survived |
| 2 | Operational error (baseline failure, bad arguments, report write failure) |

## Stryker JSON Reports

Use `--format=json` to print a [Stryker mutation testing report](https://stryker-mutator.io/docs/mutation-testing-elements/mutant-results/) to stdout, or `--json-file=report.json` to write one to a file alongside the terminal report. Stryker reports include source file contents, so the original source files must remain readable at their recorded paths when generating the report.
