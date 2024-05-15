proc instantiator*[T](x: T) = 
  mixin mixedInProc

  x.cacheableGeneric()

proc cacheableGeneric*[T](x: T) =
  x.mixedInProc()