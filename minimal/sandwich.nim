import std/options

import ./serialization
import ./serde
import ./ethers

proc sandwich*() =
  # binds mixin with everything in scope.
  discard Option[B].readValues()