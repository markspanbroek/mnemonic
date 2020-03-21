import os
import strformat

proc read(language: string): seq[string] {.compileTime.} =
  let path = currentSourcePath().parentDir
  readLines(path/"words"/fmt"{language}.txt", 2048)

let english* = read("english")
