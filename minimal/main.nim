import std/options

import ./serde
import ./sandwich # should not cause dispatch to change, but does

# Should print "serde fromJson" but will print
# "ethers fromJson" if sandwich is imported.
Option[B].fromJson()

