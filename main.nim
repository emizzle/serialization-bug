import std/options
import pkg/stint
import pkg/questionable
import pkg/questionable/results

import ./serde/deserializer
import ./sandwiched # should not affect behavior, but does

let actual = Option[UInt256].fromJson("30").tryGet.get
let expected = 30.u256

echo "Expectation: should be ",  expected, " but is ", $actual
echo if expected == actual: "PASS" else: "FAIL"

