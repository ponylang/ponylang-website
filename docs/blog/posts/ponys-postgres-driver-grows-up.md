---
date: 2026-04-09T20:00:00-04:00
title: "Pony's Postgres Driver Grows Up"
authors:
  - seantallen
categories:
  - Libraries
draft: false
---

Pony has had a Postgres driver since 2023. It didn't do much for most of those three years. That's been changing over the last couple of months.

<!-- more -->

## Where it was

[`ponylang/postgres`](https://github.com/ponylang/postgres) shipped its 0.1.0 in February 2023. It implemented just enough of the Postgres wire protocol to authenticate with MD5 and run a few simple queries. Then it sat. I didn't touch it for a couple years. I eventually landed 0.1.1 last year, and the 0.2.x line that followed was three dependency bumps with no functional changes.

This week, I landed 0.3.0. The rest of this post is what came with it.

## Why now

[Last month I wrote about `ponylang/lori`](pony-networking-take-two.md), the networking foundation Pony's web stack is being built on. [`ponylang/stallion`](stallion-http-server.md) gave us an HTTP server. [`ponylang/hobby`](https://github.com/ponylang/hobby) put a web framework on top of Stallion. [`ponylang/json`](pony-gets-a-new-json-library.md) handles JSON parsing and serialization. Each one of those is a piece of the same project: making Pony a language you can write web services in without having to build half the stack yourself first.

A web stack without a database driver isn't a web stack. It's a one-legged dog trying to compete in a three-legged race. `ponylang/postgres` 0.3.0 is part of fixing that.

Most of 0.3.0 sits on [`ponylang/lori`](https://github.com/ponylang/lori). Let me walk you through the driver.

## Connecting to a real Postgres install

Auth is automatic. The driver handles SCRAM-SHA-256, MD5, and cleartext password, and picks whichever one the server asks for.

Encryption is the part you pick. `SSLDisabled` is the default. `SSLRequired` demands encryption and fails if the server refuses. `SSLPreferred` tries SSL and falls back to plaintext if the server refuses it. Both encrypted modes use lori's `start_tls()` for the mid-stream handshake the Postgres protocol requires.

## Real queries

The simplest way to run a query is `SimpleQuery`: hand it a SQL string, get results back. That's fine for ad-hoc queries and control statements like `BEGIN`. It's not fine for anything that includes user input, because you'd be building the SQL with string concatenation and earning SQL injection as a reward.

`PreparedQuery` is how you bind values separately from the query text. You write the query with placeholders (`$1`, `$2`, and so on), hand the values in as a typed array, and the driver sends them across the wire in binary format. The server never sees a glued-together string:

```pony
let query = PreparedQuery("SELECT * FROM users WHERE id = $1",
  recover val [as FieldDataTypes: I32(42)] end)
session.execute(query, receiver)
```

If you're running the same query a lot with different values, you don't want the server parsing it from scratch every time. You want it parsed and planned once, then executed with different values. That's a named prepared statement, and `NamedPreparedQuery` is how you use it. Hand the server a name and the query text via `session.prepare()`, then fire off executions by name for as long as you want. When you're done, `session.close_statement()` cleans up the server-side state.

```pony
session.prepare("find_user", "SELECT * FROM users WHERE id = $1", receiver)

// In the PrepareReceiver callback:
be pg_statement_prepared(session: Session, name: String) =>
  session.execute(
    NamedPreparedQuery("find_user",
      recover val [as FieldDataTypes: I32(42)] end),
    result_receiver)
```

And if you've got a batch of queries to send that don't depend on each other's results, you can ship them together. `session.pipeline()` writes all of them to the socket in one go. The server works through them in order, and each result comes back indexed by its position in the batch. N round trips collapse into one. Each query has its own error isolation, so a failure in the middle doesn't poison the rest.

## Transactions

Transactions are first-class. `BEGIN`, do work, `COMMIT` or `ROLLBACK`, all through the normal `execute()` interface:

```pony
be pg_session_authenticated(session: Session) =>
  session.execute(SimpleQuery("BEGIN"), receiver)
  session.execute(SimpleQuery("INSERT INTO t (col) VALUES ('x')"), receiver)
  session.execute(SimpleQuery("COMMIT"), receiver)
```

The catch with transactions is that once a query inside one errors, Postgres marks the whole transaction as failed and rejects every subsequent statement until you `ROLLBACK`. You need to know you're in that state so you can bail out cleanly instead of sending a dozen more queries the server is just going to reject. The `pg_transaction_status` callback on `SessionStatusNotify` fires after every query cycle and tells you whether the session is idle, inside a transaction, or inside a failed one.

## Cancellations and timeouts

Sometimes a query is going to run longer than you want, and you'd like to stop it. `session.cancel()` sends a Postgres `CancelRequest` on a separate connection (the protocol requires a separate connection) and asks the server to abort whatever's currently running. It's best-effort; the server may or may not honor it. If it does, the cancelled query's `ResultReceiver` gets `pg_query_failed` with SQLSTATE `57014` (`query_canceled`).

Manually cancelling every slow query is a lot of bookkeeping. Every query operation takes an optional `statement_timeout`, and the driver handles the bookkeeping for you. It starts a one-shot timer when the query goes out, and if the query isn't done by then, the driver fires off the `CancelRequest` itself. Same SQLSTATE, same code path.

And if the server isn't reachable at all, you want to give up before TCP retry behavior hangs you for minutes. `ServerConnectInfo` takes an optional connection timeout. With one set, you get `ConnectionFailedTimeout` after the duration you pick. The difference between "hangs forever" and "fails in five seconds" is pretty much the entire game when something is broken in production.

## Bulk data and streaming

If you've got a million rows to load into Postgres, you don't want to issue a million `INSERT` statements. You want `COPY ... FROM STDIN`, which lets you stream the data straight into a table at full pipe. The driver's design for it is pull-based: it tells you when it's ready for the next chunk, you send exactly one chunk in response, and the cycle repeats until you call `finish_copy()` (or `abort_copy()` if something goes wrong on your side and you want the server to roll back). Memory usage stays bounded because there's only ever one chunk in flight.

```pony
actor BulkLoader is (SessionStatusNotify & ResultReceiver & CopyInReceiver)
  var _rows_sent: USize = 0

  be pg_session_authenticated(session: Session) =>
    session.copy_in(
      "COPY my_table (name, value) FROM STDIN", this)

  be pg_copy_ready(session: Session) =>
    _rows_sent = _rows_sent + 1
    if _rows_sent <= 1_000_000 then
      let row: Array[U8] val = recover val
        ("row" + _rows_sent.string() + "\t"
          + (_rows_sent * 10).string() + "\n").array()
      end
      session.send_copy_data(row)
    else
      session.finish_copy()
    end

  be pg_copy_complete(session: Session, count: USize) =>
    // count = number of rows copied
    None

  be pg_copy_failed(session: Session,
    failure: (ErrorResponseMessage | ClientQueryError))
  =>
    // handle the error
    None
```

`COPY ... TO STDOUT` goes the other direction: the server pushes data to you, your `pg_copy_data` callback fires for each chunk, and `pg_copy_complete` fires when the export is done. Chunks don't necessarily align with row boundaries, so if you want row-level processing you buffer until you hit a newline.

Bulk export is great when you know how much data is coming. Row streaming is for when you don't. The result set might be a thousand rows. It might be a hundred million. `session.stream()` runs a query against a Postgres portal cursor and pulls results back in fixed-size batches. You hand it a window size, your `StreamingResultReceiver` gets a batch of rows at a time, and you call `fetch_more()` when you're ready for the next one. Bounded memory, on a Postgres feature that's been there forever and the driver finally knows how to use.

```pony
session.stream(
  PreparedQuery("SELECT * FROM big_table",
    recover val Array[FieldDataTypes] end),
  100, my_receiver)

// In the receiver:
be pg_stream_batch(session: Session, rows: Rows) =>
  // process this batch
  session.fetch_more()  // pull the next one

be pg_stream_complete(session: Session) =>
  // all rows delivered
```

`StreamingResultReceiver` also has a `pg_stream_failed` callback for errors and `session.close_stream()` lets you stop pulling early without draining the cursor.

## Talking back

Postgres has things to say to clients beyond just answering queries. The driver listens to all of them.

The biggest one is `LISTEN`/`NOTIFY`, Postgres's built-in pub/sub mechanism. You subscribe to a channel by running `LISTEN my_channel` as a normal query, and from that point on, anything that runs `NOTIFY my_channel, 'payload'` (from another connection, a trigger, whatever) generates a notification that gets pushed to you asynchronously. The driver delivers it through `pg_notification` on `SessionStatusNotify`:

```pony
actor MyClient is (SessionStatusNotify & ResultReceiver)
  let _env: Env

  new create(env: Env) =>
    _env = env

  be pg_session_authenticated(session: Session) =>
    session.execute(SimpleQuery("LISTEN my_channel"), this)

  be pg_notification(session: Session, notification: Notification) =>
    _env.out.print("Got: " + notification.channel
      + " -> " + notification.payload)
```

That's a database-backed message bus you can use without standing up a separate piece of infrastructure. People build a lot of useful things on top of `LISTEN`/`NOTIFY` once they realize their database can do it.

The other two callbacks are smaller and fire whenever the server wants to tell you something about a query or about itself. `pg_notice` delivers non-fatal messages like `RAISE NOTICE` output from a stored procedure or a `DROP TABLE IF EXISTS` telling you the table wasn't there. `pg_parameter_status` fires when a server runtime parameter changes, at startup or in response to a `SET` command. Neither is load-bearing for most applications, but if you're logging server-side events or adapting to server settings, they're how you get at them. All three callbacks have default no-op implementations, so you don't have to implement any of them unless you want to.

## Real types

The driver hands you Postgres values as Pony types. Numerics and booleans decode to their Pony equivalents. Temporal types decode to typed wrappers like `PgTimestamp` and `PgDate`, each with a `string()` method that formats the value the way Postgres would. Infinity and `-infinity` come through as type-max and type-min values, so you can tell them apart from real timestamps.

Two protocol paths, two decoding behaviors. `PreparedQuery`, `NamedPreparedQuery`, streaming, and pipelining all use Postgres's binary wire format and you get the typed values described above. `SimpleQuery` uses the text format and you get strings. Fire `SELECT NOW()` through a `SimpleQuery` and you get a `String`. Fire it through a `PreparedQuery` and you get a `PgTimestamp`. The driver picks based on the query type, not the column type.

```pony
be pg_query_result(session: Session, result: Result) =>
  match result
  | let rs: ResultSet =>
    for row in rs.rows().values() do
      for field in row.fields.values() do
        match field.value
        | let s: String => // text or text-like column
          None
        | let i: I32 => // int4
          None
        | let t: PgTimestamp => // timestamp / timestamptz
          None
        | let d: PgDate => // date
          None
        | let b: Bytea => // bytea, raw bytes in b.data
          None
        | None => // SQL NULL
          None
        end
      end
    end
  end
```

One-dimensional arrays of any built-in element type decode into `PgArray` and can be sent as parameters. `int4[]`, `text[]`, `timestamp[]`: they all just work. Multi-dimensional arrays don't, yet.

For types the driver doesn't ship with, you register your own codecs. Implement the `Codec` interface, register it against the type's OID (you can find one by querying `pg_type` from `psql`), and pass the registry into the session constructor. The release notes walk through a custom codec for Postgres `point`.

Enum and composite types get shortcuts so you don't have to write the codec yourself. `CodecRegistry.with_enum_type(oid)` registers an enum so it decodes as a `String` in both binary and text formats. `CodecRegistry.with_composite_type()` decodes a composite (the kind you create with `CREATE TYPE foo AS (...)`) into a `PgComposite` you can index by position or by field name.

`Field.value` is an open `FieldData` interface so custom codecs can plug in. Any `val` class with a `string()` method qualifies as a field value. There's also a second wrapper type, `RawBytes`, for binary-format columns whose OIDs the driver doesn't recognize. (`Bytea` is for known `bytea` columns; `RawBytes` is for unknown binary OIDs that show up before you've registered a codec.) The cost of an open interface is that `match` on `field.value` isn't exhaustive in the type system's eyes, even when you've handled every type the driver itself ships. That tradeoff is deliberate: closed-union exhaustiveness on field values is only useful if you can actually enumerate every type, and the moment user codecs are in play, you can't. The codecs you control are the ones you handle.

## Errors as data

Every time the driver hands you something that could be one of several things (what kind of result you got, why the connection failed, what kind of query it was), it's a closed union. Match exhaustively on any of them and the compiler will tell you if you missed a case. That covers `Result`, `ClientQueryError`, `AuthenticationFailureReason`, `ConnectionFailureReason`, `TransactionStatus`, `SSLMode`, `Query`, and `FieldDataTypes`.

This is the same pattern the rest of Pony pushes you toward: errors are data, not exceptions, and the type system should make sure you've thought about each one.

## What's still missing

The driver is beta. Here's what you won't find in it yet:

- Authentication methods beyond SCRAM-SHA-256, MD5, and cleartext password (Kerberos, GSSAPI, SCM, SSPI, SCRAM-SHA-256-PLUS with channel binding, and certificate-based auth)
- Function calls via the legacy `Fastpath` protocol
- Multi-dimensional arrays (one-dimensional arrays work)
- Most startup configuration parameters beyond the basics

The README has the canonical list of what's in and what isn't. If any of these gaps are blocking your work, file an issue and we'll talk about it. PRs are welcome too. The driver goes where the Pony community pushes it.

## Try it

`ponylang/postgres` 0.3.1 is the current release. (0.3.0 had a backpressure stall in lori that 0.3.1 picked up a fix for. The 0.3.0 feature set is the one this post walks through.) Install with corral:

```bash
corral add github.com/ponylang/postgres.git --version 0.3.1
corral fetch
```

You'll also need a C SSL library installed. The driver pulls in [`ponylang/ssl`](https://github.com/ponylang/ssl) as a transitive dependency, and that needs OpenSSL or LibreSSL on your system. The [ssl installation instructions](https://github.com/ponylang/ssl?tab=readme-ov-file#installation) cover what to install where.

The [README](https://github.com/ponylang/postgres) has the full API surface. The [release notes](https://github.com/ponylang/postgres/releases/tag/0.3.0) have the details on every entry I covered here, plus the ones I didn't (equality on `Field`, `Row`, and `Rows`, sending a `Terminate` message before close, follow-up queries from receiver callbacks). If you find something broken or missing, the [issue tracker](https://github.com/ponylang/postgres/issues) is where to put it.

Pony has a Postgres driver now. Not the proof-of-concept version we'd had since 2023. The actual one. I know. Three years late, but hey, now it's yours to break.
