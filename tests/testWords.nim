import unittest
import mnemonic/words

test "converts an integer index to an english word":
  check indexToWord(42) == "aim"

test "refuses to convert an index higher than 2047":
  expect Exception:
    discard indexToWord(2048)

test "converts an english word to an integer index":
  check wordToIndex("aim") == 42

test "refuses to convert a word that's not in the word list":
  expect Exception:
    discard wordToIndex("invalid")
