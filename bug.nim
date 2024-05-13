from pkg/ethers import Address

import std/options
import pkg/serde/json
import pkg/stint
import pkg/questionable

let actual = Option[UInt256].fromJson("\"30\"").tryGet.get
let expected = 30.u256

echo $expected & " == " & $actual

doAssert expected == actual

