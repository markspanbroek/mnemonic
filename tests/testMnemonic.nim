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
