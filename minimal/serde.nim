import std/options

import ./types

export types

proc fromJson*(T: typedesc[A or B]) = 
  static:
    echo "instantiate fromJson serde A or B ", T
    echo currentSourcePath()

  echo "serde fromJson"

proc fromJson*[T](_: type Option[T]) = 
  static:
    echo "instantiate fromJson serde Option[T] ", T
    echo currentSourcePath()

  T.fromJson()
