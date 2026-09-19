# Ecosystem {:id="ecosystem"}

## Does Pony have a package manager? {:id="package-manager"}

That would be yes and no. Package manager means different things to different people. What we have is a simple dependency manager called [corral](https://github.com/ponylang/corral) that we are working on growing into a full featured tool. Whether that is a more full featured "dependency manager" or more full featured "package manager" depends on how you define the two terms.

## Does Pony have a formatter? {:id="code-formatter"}

At this time, no. There is no formatter for Pony code. The lack of a formatter doesn't indicate that the Pony core team is opposed to code formatters. There is strong interest in having a code formatter for Pony.

An easy to maintain code formatter would share parsing code with the compiler. At this time, sharing said code is difficult. We are working towards making maintaining a code formatter and other parsing related tooling easier. We plan to introduce a code formatter in the future.

## Is there SSL support? {:id="ssl"}

Yes! The standard library's `crypto` package provides cryptographic primitives (hash functions, HMAC, PBKDF2, random bytes) backed by OpenSSL's libcrypto. The standard library's `net` package provides SSL/TLS connections via OpenSSL's libssl.
