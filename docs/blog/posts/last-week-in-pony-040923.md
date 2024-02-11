---
draft: false
author: "seantallen"
description: "An epic Office Hours debugging session"
categories:
  - "Last Week in Pony"
title: "Last Week in Pony April 9, 2023"
date: 2023-04-09T07:00:06-04:00
---

This week in Pony was highlighted by a long debugging session during Office Hours and the merging of LLVM 15 support to main during the Pony Development Sync. A huge thanks to Joe for doing the heavy lifting on getting us up and running on LLVM 15.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_04_04.m4a) from the April 4th, 2023 sync is available.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours this week was a long one. We started 30 minutes early and went for close to two hours. The time was all spent with Joe and Sean investigating further into [issue #4340](https://github.com/ponylang/ponyc/issues/4340).

Prior to the call, Sean had already tracked down the problem to an interaction between 3 optimization passes: the inliner, the custom Pony "HeapToStack" pass, and LLVM's built in "Dead Store Eliminator".

When these 3 optimization passes are on, the following code that should pass it's test fails because we incorrectly end up with "2" rather than "3" as a value.

```pony
use "pony_test"

interface Tree
  fun get_value(): USize
  fun univals(): USize

class Leaf is Tree
  let _value: USize

  new create(value: USize) =>
    _value = value

  fun get_value(): USize => _value

  fun univals(): USize => 1

class Node
  let _value: USize
  let _left: Tree
  let _right: Tree

  new create(value: USize, left: Tree, right: Tree) =>
    _value = value
    _left  = left
    _right = right

  fun get_value(): USize => _value

  fun univals(): USize =>
    let left_univals  = _left.univals()
    let right_univals = _right.univals()
    if (_left.get_value() == _right.get_value())
       and (_left.get_value() == this.get_value()) then
      1 + left_univals + right_univals
    else
      left_univals + right_univals
    end

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestUnivals)

class iso _TestUnivals is UnitTest
  fun name(): String => "univals"

  fun apply(h: TestHelper) =>
    h.assert_eq[USize](3, Node(0, Leaf(0), Leaf(0)).univals())
```

Joe's suspicion going into the debugging session was that the problem lay within the "HeapToStack" optimization; a reasonable suspicion to hold- bugs are generally found more often in "our code" rather than "their code". Sean was less sure and thought that it might be an unexpected interaction between two sets of code that are otherwise "correct". And that it was possible that neither was doing something "wrong" but that we were running into "unspecified assumptions".

The debugging session started with 30 minutes of setup as it was determined that we needed to use a debug version of LLVM. Fortunately, Sean's laptop has 18 cores to throw at the problem so compilation of LLVM didn't take to long.

The next 90-ish minutes were spent investigating the problem. Included below is an "annotated" version of the LLVM ir after the last HeapToStack optimization is applied (and prior to any dead store elimination being done):

```llvm
define private fastcc ptr @_TestUnivals_ref_apply_oo(ptr nocapture readnone %this, ptr nocapture readonly dereferenceable(24) %h) unnamed_addr !dbg !7533 !pony.abi !4 {
entry:
  %_leaf_right = alloca i8, i64 32, align 8
  %_leaf_left = alloca i8, i64 32, align 8
  store ptr @Leaf_Desc, ptr %_leaf_left, align 8
  %_leaf_left_value = getelementptr inbounds %Leaf, ptr %_leaf_left, i64 0, i32 1, !dbg !7539
  store i64 0, ptr %_leaf_left_value, align 8, !dbg !7539
  store ptr @Leaf_Desc, ptr %_leaf_right, align 8
  %_leaf_right_value = getelementptr inbounds %Leaf, ptr %_leaf_right, i64 0, i32 1, !dbg !7542
  store i64 0, ptr %_leaf_right_value, align 8, !dbg !7542
  %_leaf_left_univals = tail call fastcc i64 @Leaf_ref_univals_Z(ptr nonnull %_leaf_left), !dbg !7547
  %_leaf_left_get_value = tail call fastcc i64 @Leaf_ref_get_value_Z(ptr nonnull %_leaf_left), !dbg !7548
  %_leaf_right_get_value = tail call fastcc i64 @Leaf_ref_get_value_Z(ptr nonnull %_leaf_right), !dbg !7549
  %8 = icmp eq i64 %_leaf_left_get_value, %_leaf_right_get_value
  br i1 %8, label %sc_right.i, label %Node_ref_univals_Z.exit

sc_right.i:                                       ; preds = %entry
  %9 = icmp eq i64 %_leaf_left_get_value, 0
  %10 = zext i1 %9 to i64
  %spec.select.i = add i64 %_leaf_left_univals, %10
  br label %Node_ref_univals_Z.exit

Node_ref_univals_Z.exit:                          ; preds = %entry, %sc_right.i
  %.pn.i = phi i64 [ %_leaf_left_univals, %entry ], [ %spec.select.i, %sc_right.i ]
  %_leaf_right_univals = tail call fastcc i64 @Leaf_ref_univals_Z(ptr nonnull %_leaf_right), !dbg !7550
  %12 = add i64 %.pn.i, %_leaf_right_univals
  %13 = tail call fastcc i1 @pony_test_TestHelper_val__check_eq_USize_val_oZZoob(ptr nonnull %h, ptr nonnull @19, i64 3, i64 %12, ptr nonnull @39, ptr nonnull @"$1$0_Inst"), !dbg !7555
  call void @llvm.dbg.value(metadata ptr @None_Inst, metadata !5286, metadata !DIExpression()), !dbg !7556
  ret ptr @None_Inst, !dbg !7558
}
```

In the IR above, we've removed some purely debugging information and replaced some LLVM IR descriptors like `%0` with more human meaningful names.

Joe was expecting to see "something wrong" in the IR at this point, but, everything looks good. There's nothing we can see that is "wrong". However, once the dead store elimination is done, we ended up with the following IR:

```llvm
define private fastcc ptr @_TestUnivals_ref_apply_oo(ptr nocapture readnone %this, ptr nocapture readonly dereferenceable(24) %h) unnamed_addr !dbg !7533 !pony.abi !4 {
entry:
  %0 = alloca i8, i64 32, align 8
  %1 = alloca i8, i64 32, align 8
  %3 = tail call fastcc i64 @Leaf_ref_univals_Z(ptr nonnull %1), !dbg !7543
  %4 = tail call fastcc i64 @Leaf_ref_get_value_Z(ptr nonnull %1), !dbg !7544
  %5 = tail call fastcc i64 @Leaf_ref_get_value_Z(ptr nonnull %0), !dbg !7545
  %6 = icmp eq i64 %4, %5
  br i1 %6, label %sc_right.i, label %Node_ref_univals_Z.exit

sc_right.i:                                       ; preds = %entry
  %7 = icmp eq i64 %4, 0
  %8 = zext i1 %7 to i64
  %spec.select.i = add i64 %3, %8
  br label %Node_ref_univals_Z.exit

Node_ref_univals_Z.exit:                          ; preds = %entry, %sc_right.i
  %.pn.i = phi i64 [ %3, %entry ], [ %spec.select.i, %sc_right.i ]
  %9 = tail call fastcc i64 @Leaf_ref_univals_Z(ptr nonnull %0), !dbg !7546
  %10 = add i64 %.pn.i, %9
  %11 = tail call fastcc i1 @pony_test_TestHelper_val__check_eq_USize_val_oZZoob(ptr nonnull %h, ptr nonnull @19, i64 3, i64 %10, ptr nonnull @39, ptr nonnull @"$1$0_Inst"), !dbg !7549
  ret ptr @None_Inst, !dbg !7550
}
```

Where things are most definitely wrong. The loading of values needed for correct execution of the code is gone from `@_TestUnivals_ref_apply_oo`. It would appear, that the dead store elimination doesn't recognize that the objects allocated here:

```llvm
  %0 = alloca i8, i64 32, align 8
  %1 = alloca i8, i64 32, align 8
```

are accessed later and optimizes the loading of values from them away. At the time that we had to stop, we hadn't yet hit on a reason for why that was happening. In hand wave terms, the two most likely problems are:

- Bug in dead store elimination
- `alloca`s that are created by heap to stack pass are "incorrect" in that they are set up in a way that other LLVM passes doesn't fully understand them.

Debugging will continue further this week, including perhaps at another Office Hours.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are looking at Frequently Asked Questions (FAQs), specifically [Does Pony have green threads?](https://www.ponylang.io/faq/#green-threads).

The answer really depends on what you expect from green threads. By default, Pony has one "actor thread" per CPU and these are kernel threads. These actor threads are then used to schedule actors. You as the programmer never interact with threads directly, instead you model your problem through messages passed between actors.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
