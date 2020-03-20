import mnemonic/bits
import mnemonic/words
import strutils
import sequtils
import nimsha2

func hash(bytes: openArray[byte]): seq[bool] =
  let sha = computeSHA256(cast[string](bytes.toSeq))
  result = cast[seq[byte]](sha.toSeq).toBits

func checksum(bytes: openArray[byte]): seq[bool] =
  let length = (bytes.len * 8) div 32
  result = hash(bytes)[0..length-1]

proc encode*(bytes: openArray[byte]): string =
  assert bytes.len * 8 in [128, 160, 192, 224, 256]
  let bits = bytes.toBits & checksum(bytes)
  let chunks = bits.distribute(bits.len div 11)
  let indices = chunks.mapIt(it.toUInt16)
  let words = indices.mapIt(english[it])
  result = words.join(" ")
