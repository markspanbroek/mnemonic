import os
import strformat
import algorithm

proc read(language: string): seq[string] {.compileTime.} =
  let path = currentSourcePath().parentDir
  readLines(path/"words"/fmt"{language}.txt", 2048)

let english* = read("english")

proc indexToWord*(index: uint16): string =
  english[index]

proc wordToIndex*(word: string): uint16 =
  let index = english.binarySearch(word)
  assert index >= 0
  return index.uint16
