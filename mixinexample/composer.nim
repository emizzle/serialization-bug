import ./[types, procset2, instantiator]

proc resolve(x: Specialized) = 
  x.instantiator()