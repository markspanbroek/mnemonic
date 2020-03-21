import unittest
import mnemonic
import sequtils

test "encodes bytes as mnemonic":
  let bytes: seq[byte] = repeat(0x7f'u8, 32)
  let mnemonic =
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth title"
  check encode(bytes) == mnemonic

test "refuses to encode bytes that are not a multiple of 32 bits":
  let bytes: seq[byte] = repeat(0x7f'u8, 31)
  expect Exception:
    discard encode(bytes)

test "refuses to encode bytes that are less than 128 bits":
  let bytes: seq[byte] = repeat(0x7f'u8, 8)
  expect Exception:
    discard encode(bytes)

test "refuses to encode bytes that are more than 256 bits":
  let bytes: seq[byte] = repeat(0x7f'u8, 64)
  expect Exception:
    discard encode(bytes)

test "decodes mnemonic into bytes":
  let mnemonic =
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth title"
  let bytes: seq[byte] = repeat(0x7f'u8, 32)
  check decode(mnemonic) == bytes

test "refuses to decode when checksum fails":
  let mnemonic =
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth toast"
  expect Exception:
    discard decode(mnemonic)

test "refuses to decode when invalid words are used":
  let mnemonic =
    "invalid zoo zoo zoo zoo zoo zoo zoo " &
    "zoo zoo zoo zoo zoo zoo zoo zoo " &
    "zoo zoo zoo zoo zoo zoo zoo vote"
  expect Exception:
    discard decode(mnemonic)

test "refuses to decode bytes that are less than 128 bits":
  let mnemonic = "legal winner thank year wave sausage"
  expect Exception:
    discard decode(mnemonic)

test "refuses to decode bytes that are more than 256 bits":
  let mnemonic =
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth useful " &
    "legal winner thank year wave sausage worth useful " &
    "legal winner wrap"
  expect Exception:
    discard decode(mnemonic)
