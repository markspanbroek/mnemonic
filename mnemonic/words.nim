import os
import strformat

proc read(language: string): seq[string] {.compileTime.} =
  readLines("mnemonic"/"words"/fmt"{language}.txt", 2048)

let english* = read("english")
