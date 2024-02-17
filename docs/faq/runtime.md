# Runtime {:id="runtime"}

## Does Pony have green threads? {:id="green-threads"}

The short answer is no. Pony doesn't have green threads. By default, the Pony scheduler starts 1 "actor thread" per available CPU. These threads are used to schedule actors. Each of these threads is a kernel thread.

The longer answer is "it depends". Actors are Pony's unit of concurrency and many people when asking if Pony has green threads really are asking about how concurrency is modeled. You, as a Pony programmer, never interact with scheduler threads directly, you never interact with any sort of thread. You worry about actors and sending messages between them.

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
