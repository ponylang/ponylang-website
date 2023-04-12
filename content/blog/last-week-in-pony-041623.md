+++
draft = false
author = "seantallen"
description = "Pony 0.54.1 was released. Updating as soon as possible is advised."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony April 16, 2023"
date = "2023-04-16T07:00:06-04:00"
+++

In our [previous edition of "Last Week in Pony"](https://www.ponylang.io/blog/2023/04/last-week-in-pony-april-9-2023/), we [covered the exploration](https://www.ponylang.io/blog/2023/04/last-week-in-pony-april-9-2023/#office-hours) of [ponyc issue #4340](https://github.com/ponylang/ponyc/issues/4340) that happened during the April 7th Office Hours. This week, we are happy to report that the bug [has been fixed](https://github.com/ponylang/ponyc/pull/4341). You can check out this week's Pony Development Sync to hear Sean and Joe work through the final bits of the bug and you can enjoy the fruits of those labors by installing Pony 0.54.1 which was released this week.

<!-- more -->

## Items of Note

### "Upgrade immediately" Pony released

[Pony 0.54.1 was released](https://github.com/ponylang/ponyc/releases/tag/0.54.1) this week. It fixes an incorrect optimization pass that could result in incorrect code being generated. We recommend updating as soon as you can.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_04_11.m4a) from the April 11th, 2023 sync is available.

This week's sync call had a single item on the agenda and we used the full hour on it. The call is a continuation of Office Hours [from the previous week](https://www.ponylang.io/blog/2023/04/last-week-in-pony-april-9-2023/#office-hours).

Joe and Sean spent the hour going over the additional information that Sean had collected over the weekend on [issue #4340](https://github.com/ponylang/ponyc/issues/4340). Over the course of the call, Sean and Joe narrowed in on the problem until at the end of the call, they had a proposed solution. Shortly after the call, Sean tested the fix and verified that it worked.

For those who love LLVM IR, this IR that we previously stated "looked good" is actually slightly buggy:

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

In particular, these calls are problematic:

```llvm
  %_leaf_left_get_value = tail call fastcc i64 @Leaf_ref_get_value_Z(ptr nonnull %_leaf_left), !dbg !7548
  %_leaf_right_get_value = tail call fastcc i64 @Leaf_ref_get_value_Z(ptr nonnull %_leaf_right), !dbg !7549
```

The problem is that these calls access memory that came from an `alloca`...

```llvm
  %_leaf_right = alloca i8, i64 32, align 8
  %_leaf_left = alloca i8, i64 32, align 8
```

and was initialized here...

```llvm
  %_leaf_left_value = getelementptr inbounds %Leaf, ptr %_leaf_left, i64 0, i32 1, !dbg !7539
  store i64 0, ptr %_leaf_left_value, align 8, !dbg !7539
  store ptr @Leaf_Desc, ptr %_leaf_right, align 8
  %_leaf_right_value = getelementptr inbounds %Leaf, ptr %_leaf_right, i64 0, i32 1, !dbg !7542
  store i64 0, ptr %_leaf_right_value, align 8, !dbg !7542
```

Each of the `Leaf_ref_get_value_Z` calls accesses memory that was initialized in a corresponding store, but that isn't clear from the IR. In fact the `tail` annotations on the highlighted `call`s indicate that no memory from an `alloca` is going to be accessed.

Lacking this knowledge, those stores get removed by a later optimization pass as it appears from the IR that they aren't used. Hilarity ensues.

The core of the issue is that the `HeapToStack` pass doesn't do any alias analysis and as such, when it only sets some calls within a function where a heap call has been turned into an `alloca` as "not tail". To be safe without some alias analysis, all `call` invocations need to be "tail false".

The fix does just that...

```diff
--- a/src/libponyc/codegen/genopt.cc
+++ b/src/libponyc/codegen/genopt.cc
@@ -235,6 +235,28 @@ class HeapToStack : public PassInfoMixin<HeapToStack>
         case Instruction::Call:
         case Instruction::Invoke:
         {
+          // Record any calls that are tail calls so they can be marked as
+          // "tail false" if we do a HeapToStack change. Accessing `alloca`
+          // memory from a call that is marked as "tail" is unsafe and can
+          // result in incorrect optimizations down the road.
+          //
+          // See: https://github.com/ponylang/ponyc/issues/4340
+          //
+          // Technically we don't need to do this for every call, just calls
+          // that touch alloca'd memory. However, without doing some alias
+          // analysis at this point, our next best bet is to simply mark
+          // every call as "not tail" if we do any HeapToStack change. It's
+          // "the safest" thing to do.
+          //
+          // N.B. the contents of the `tail` list will only be set to
+          // "tail false" if we return `true` from this `canStackAlloc`
+          // function.
+          auto ci = dyn_cast<CallInst>(inst);
+          if (ci && ci->isTailCall())
+          {
+            tail.push_back(ci);
+          }
+
           auto call_base = dyn_cast<CallBase>(inst);
           if (!call_base)
           {
@@ -275,12 +297,6 @@ class HeapToStack : public PassInfoMixin<HeapToStack>
                 print_transform(c, inst, "captured here (call arg)");
                 return false;
               }
-
-              auto ci = dyn_cast<CallInst>(inst);
-              if (ci && ci->isTailCall())
-              {
-                tail.push_back(ci);
-              }
             }
           }
           break;
```

It was quite the productive call. We're not sure how much the listeners got out of it, but Joe and Sean made tremendous progress and folks we have a compiler bug fixed! If this sort of thing interests you, please feel free to attend a Pony Development Sync. We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponyc 0.54.1](https://github.com/ponylang/ponyc/releases/tag/0.54.1)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
