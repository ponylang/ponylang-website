# Runtime {:id="runtime"}

## Does Pony have green threads? {:id="green-threads"}

The short answer is no. Pony doesn't have green threads. By default, the Pony scheduler starts 1 "actor thread" per available CPU. These threads are used to schedule actors. Each of these threads is a kernel thread.

The longer answer is "it depends". Actors are Pony's unit of concurrency and many people when asking if Pony has green threads really are asking about how concurrency is modeled. You, as a Pony programmer, never interact with scheduler threads directly, you never interact with any sort of thread. You worry about actors and sending messages between them.

## Are pony actors lightweight like Elixir/Erlang's actors, or Go's goroutines? {:id="pony-actors-lightweight"}

Yes! In Pony, the overhead of an empty actor on a 64-bit system is roughly 240 bytes -- depending on your system's `size_t` and alignment. Complete actor overhead includes a message queue, per-actor heap, and GC bookkeeping; therefore, memory use increases as an actor accumulates messages and grows its heap. Actors do not have individual stacks, rather they use the stack of the OS thread they are scheduled on.

Relatively, Elixir/Erlang actors use ~5x more memory and goroutines use ~8x more memory, but critically Elixir/Erlang and Go handle memory far differently than Pony. The memory management approach that is "best" is project-dependent -- Pony offers one more option you can consider for your particular needs.

## Does Pony really prevent data races? {:id="data-race"}

So, this question usually comes in many different forms. And the question usually arises from a misunderstanding of the difference between a "data race" and a "race condition".

Pony prevents data races. It can't stop you from writing race conditions into your program.

To learn more about the differences between race conditions and data races, check out ["Race Condition vs. Data Race"](https://blog.regehr.org/archives/490) by John Regehr.

## What is causal messaging? {:id="causal-messaging"}

When we say that Pony has causal **messaging**, we mean that the Pony runtime provides certain guarantees about message delivery order. Given two actors, actor A and actor B. All messages sent from actor A will arrive at actor B in the order they were sent by Actor A and will be processed by Actor B in the same order. The causal ordering between messages will be preserved as an invariant by the runtime.

Causal ordering of messages applies to a chain of message sends as well. If actor A sends M1 to B, and after that, sends M2 to C, then the messages at B and C can run in any order and in parallel. However, if C sends a message to B, even through another chain of actors, then it will always arrive after M1. You can think of a message inbox at B, where the first events added are processed first. In this case, A ensures that M1 is added to B's inbox before it goes on to send other messages.

It's essential to note that this ordering was created directly between A and M1 in B. If we had another actor, say if both M1 in B, and M2 in C happened to include a message send to D, then there's no relationship between those messages in D.

More formally, causal messaging can be broken down into a few rules:

- A message is executed some time after it is sent.
- Executions within one actor are sequential: earlier sends happen before later sends.
- Messages received earlier are executed earlier: If M1 is sent to B before M2 is, then M1 executes before M2.
- Causal ordering is transitive: if an event X happens before Y, and Y before Z, then X happens before Z.

## When do programs exit? {:id="program-exit"}

Programs exit when they reach *quiescence*.

Quiescence is perhaps a term you are unfamiliar with unless you have worked with actor systems previously. In short, quiescence is the state of being calm or otherwise inactive. In Pony, individual actors as well as the program can be quiescent. Because of this there is no need to explicitly exit your program, once no more work is being performed and no more work can be produced then the program will exit.

An individual actor is quiescent when:

- it has an empty message queue
- it has no aliases remaining to it so cannot be sent new messages
- it is not registered for events from the runtime via the ASIO subsystem

Once all actors are quiescent, the program will terminate.

## Is Pony's file IO blocking or non-blocking? {:id="file-io-blocking"}

Both, depending on what kind of IO you mean.

Network IO is fully asynchronous. It uses epoll on Linux and kqueue on macOS and BSDs. Your actors get notified when data arrives. No threads block waiting for packets.

File IO and DNS resolution are blocking. When you read from or write to a file, that operation blocks the scheduler thread running your actor. This is a pragmatic choice. Cross-platform async file IO support is poor. POSIX async IO APIs are unreliable and the alternatives are platform-specific.

In practice, short file operations are fine. If you need to do heavy file IO without tying up a scheduler thread, break the work into smaller chunks across multiple behavior calls.

## Is recursion within a behavior asynchronous? {:id="behavior-recursion"}

Yes. Behaviors are always asynchronous. When a behavior calls itself, it sends a new message to the actor's own queue. The current behavior finishes, and the recursive call runs later when the actor picks that message up.

This is actually useful. A behavior that loops with `while` or `for` can't be interrupted — it holds the scheduler thread until it returns. A behavior that "loops" by calling itself gives other messages a chance to be processed between iterations. The [`yield`](https://github.com/ponylang/ponyc/tree/main/examples/yield) example in `ponylang/ponyc` demonstrates this pattern.

If you need synchronous recursion inside an actor, use a private function instead. Functions are always synchronous.
