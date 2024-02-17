# Guiding Principles

Throughout the design and development of the language, the following principles should be adhered to.

- Use the get-stuff-done approach.

- Simple grammar. Language must be trivial to parse for both humans and computers.

- No loadable code. Everything is known to the compiler.

- Fully type safe. There is no "trust me, I know what I'm doing" coercion.

- Fully memory safe. There is no "this random number is really a pointer, honest."

- No crashes. A program that compiles should never crash (although it may hang or do something unintended).

- Sensible error messages. Where possible use simple error messages for specific error cases. It is fine to assume the programmer knows the definitions of words in our lexicon, but avoid compiler or other computer science jargon.

- Inherent build system. No separate applications required to configure or build.

- Aim to reduce common programming bugs through the use of restrictive syntax.

- Provide a single, clean and clear way to do things rather than catering to every programmer's preferred prejudices.

- Make upgrades clean. Do not try to merge new features with the ones they are replacing, if something is broken remove it and replace it in one go. Where possible provide rewrite utilities to upgrade source between language versions.

- Reasonable build time. Keeping down build time is important, but less important than runtime performance and correctness.

- Allowing the programmer to omit some things from the code (default arguments, type inference, etc) is fine, but fully specifying should always be allowed.

- No ambiguity. The programmer should never have to guess what the compiler will do, or vice-versa.

- Document required complexity. Not all language features have to be trivial to understand, but complex features must have full explanations in the docs to be allowed in the language.

- Language features should be minimally intrusive when not used.

- Fully defined semantics. The semantics of all language features must be available in the standard language docs. It is not acceptable to leave behavior undefined or "implementation dependent".

- Efficient hardware access must be available, but this does not have to pervade the whole language.

- The standard library should be implemented in Pony.

- Interoperability. Must be interoperable with other languages, but this may require a shim layer if non-primitive types are used.

- Avoid library pain. Use of 3rd party Pony libraries should be as easy as possible, with no surprises. This includes writing and distributing libraries and using multiple versions of a library in a single program.
