import mnemonic/bits
import mnemonic/words
import strutils
import sequtils
import nimSHA2

func hash(bytes: openArray[byte]): seq[bool] =
  let sha = computeSHA256(cast[string](bytes.toSeq))
  result = cast[seq[byte]](sha.toSeq).toBits

func checksum(bytes: openArray[byte]): seq[bool] =
  let length = (bytes.len * 8) div 32
  result = hash(bytes)[0..length-1]

func checkLength(bytes: openArray[byte]) =
  assert bytes.len * 8 in [128, 160, 192, 224, 256]

proc encode*(bytes: openArray[byte]): string =
  checkLength(bytes)
  let bits = bytes.toBits & checksum(bytes)
  let chunks = bits.distribute(bits.len div 11)
  let indices = chunks.mapIt(it.toUInt16)
  let words = indices.mapIt(indexToWord(it))
  result = words.join(" ")

proc decode*(mnemonic: string): seq[byte] =
  let words = mnemonic.split(" ")
  let indices = words.mapIt(wordToIndex(it))
  let chunks = indices.mapIt(it.toBits[^11..^1])
  let bits = concat(chunks)
  let length = bits.len - bits.len mod 32
  result = bits[0..length-1].toBytes
  checkLength(result)
  assert checksum(result) == bits[length..bits.len-1]
