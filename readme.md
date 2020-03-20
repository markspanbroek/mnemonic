Mnemonic
========

Create memorable sentences from byte strings. Uses a reversible method that
is very similar to Bitcoin's [BIP39][1].

Examples
--------

Generate a random key and encode it into a mnemonic:

```nim
import sysrandom
import mnemonic

echo encode(getRandomBytes(32))
```

[1]: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
