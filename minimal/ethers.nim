import ./serde

proc fromJson*(T: typedesc[B]) =
  static:
    echo "instantiate fromJson ethers B"
    echo currentSourcePath()

  echo "ethers fromJson"

proc readValue*[T](result: var T) =
  # Calls
  T.fromJson()
  result = default(T)