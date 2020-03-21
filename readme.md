Mnemonic
========

Create memorable sentences from byte sequences. Uses a reversible method that
is very similar to Bitcoin's [BIP39][1].

Examples
--------

Generate a random key and encode it into a mnemonic:

```nim
import sysrandom
import mnemonic

let key = getRandomBytes(32)
let mnemonic = encode(key)
```

Decode a mnemonic into bytes:

```nim
let decoded = decode(mnemonic) # equals key
```

[1]: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
