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

proc fromJson*[T: ref object or object](_: type Option[T], json: string) = 
  static:
    echo "instantiate fromJson serde ref object or object ", T
    echo currentSourcePath()

  echo "String is ", json
  Option[T].fromJson()
