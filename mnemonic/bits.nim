import sequtils
import bitops

iterator bits*(bytes: openArray[byte]): bool =
  for b in bytes:
    var mask = 1u8 shl 7
    for i in 0..7:
      yield (b and mask) != 0
      mask = mask shr 1

func toBits*(bytes: openArray[byte]): seq[bool] =
  for b in bytes.bits:
    result.add(b)

iterator bytes*(bits: openArray[bool]): byte =
  for chunk in bits.toSeq.distribute(bits.len div 8):
    yield chunk.foldl((a shl 1) or uint8(b), 0'u8)

func toBytes*(bits: openArray[bool]): seq[byte] =
  for b in bits.bytes:
    result.add(b)

func toUInt16*(bits: openArray[bool]): uint16 =
  for bit in bits:
    result = (result shl 1) or uint16(bit)

func toBits*(integer: uint16): seq[bool] =
  for index in 1..16:
    let mask = rotateRightBits(1'u16, index)
    result.add((integer and mask) != 0)
