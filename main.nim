import std/options
import pkg/stint
import pkg/questionable
import pkg/questionable/results

import ./ethers
import ./serde

let actual = Option[UInt256].fromJson("30").tryGet.get
let expected = 30.u256

echo $expected & " == " & $actual

doAssert expected == actual
