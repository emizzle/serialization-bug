proc readValues*(T: type): T  =
  mixin readValue

  static:
    echo "Mixing in readValue"

  result = default(T)
  readValue(result) # triggers cascading resolution
