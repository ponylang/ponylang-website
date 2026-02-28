# Papers

If reading academic papers is your thing, you're in luck. There are a number of papers that have been written about Pony. We host a number of them on this website. If you're interested in learning more about "deep Pony", these papers are a great place to start.

## [Pony: Co-designing a Type System and a Runtime](/media/papers/codesigning.pdf)

The best overview paper. Explains how Pony's type system and runtime were designed together so that reference capabilities enable a concurrent garbage collector without stop-the-world pauses.

## [Deny Capabilities for Safe, Fast Actors](/media/papers/fast-cheap.pdf)

Introduces deny capabilities, the formal foundation for Pony's reference capability system. Shows how denying certain operations on a reference (rather than granting them) lets the type system guarantee data-race freedom.

## [A Principled Design of Capabilities in Pony](/media/papers/a_prinicipled_design_of_capabilities_in_pony.pdf)

Extends the deny capabilities work with a more complete formalization. Covers viewpoint adaptation, safe-to-write, and how capabilities compose under aliasing and subtyping.

## [ORCA: GC and Type System Co-Design for Actor Languages](/media/papers/orca_gc_and_type_system_co-design_for_actor_languages.pdf)

Describes Pony's production garbage collector. ORCA uses the type system's knowledge of reference capabilities to do per-actor garbage collection with no stop-the-world pauses and no read or write barriers.

## [Ownership and Reference Counting based Garbage Collection in the Actor World](/media/papers/OGC.pdf)

An earlier take on actor garbage collection that influenced ORCA. Combines ownership tracking with reference counting to collect both objects within an actor and actors themselves.

## [Fully Concurrent Garbage Collection of Actors on Many-Core Machines](/media/papers/opsla237-clebsch.pdf)

Focuses on collecting actors themselves (not just the objects they own) without stopping the world. Covers the protocol for detecting when an actor is unreachable and can be reclaimed.

## [A String of Ponies: Transparent Distributed Programming with Actors](/media/papers/a_string_of_ponies.pdf)

Explores distributing Pony actors across multiple machines. Actors communicate the same way whether local or remote, so distribution is transparent to the programmer.

## [Formalizing Generics for Pony](/media/papers/formalizing-generics-for-pony.pdf)

Covers how generic types interact with reference capabilities. Works through the formalism for constraining type parameters with capabilities and how that affects subtyping.
