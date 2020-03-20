import unittest
import mnemonic/bits

test "converts bytes to bits":
  let bytes = @[0b11001100'u8, 0b00110011'u8]
  check bytes.toBits ==
    @[true, true, false, false, true, true, false, false] &
    @[false, false, true, true, false, false, true, true]

test "converts bits to bytes":
  let bits =
    @[true, true, false, false, true, true, false, false] &
    @[false, false, true, true, false, false, true, true]
  check bits.toBytes == @[0b11001100'u8, 0b00110011'u8]

test "converts bits to integers":
  let bits = @[true, false, true, false]
  check bits.toUInt16 == 10
