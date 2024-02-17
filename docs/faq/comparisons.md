# Comparisons to Other Languages

## How is Pony different than Erlang/Elixir? {:id="erlang-elixir-comparison"}

The answer is deep and complicated. Fortunately, Scott Fritchie went to a great deal of trouble answering it in his talk [The wide world of almost-actors: comparing the Pony to BEAM languages](https://www.youtube.com/watch?v=_0m0_qtfzLs).

## Are pony actors lightweight like Elixir/Erlang's actors, or Go's goroutines? {:id="pony-actors-lightweight"}

Yes! In Pony, the overhead of an empty actor on a 64-bit system is roughly 240 bytes -- depending on your system's `size_t` and alignment. Complete actor overhead includes a message queue, per-actor heap, and GC bookkeeping; therefore, memory use increases as an actor accumulates messages and grows its heap. Actors do not have individual stacks, rather they use the stack of the OS thread they are scheduled on.

Relatively, Elixir/Erlang actors use ~5x more memory and goroutines use ~8x more memory, but critically Elixir/Erlang and Go handle memory far differently than Pony. The memory management approach that is "best" is project-dependent -- Pony offers one more option you can consider for your particular needs.
