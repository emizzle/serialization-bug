import std/options
import pkg/stint
import pkg/questionable
import pkg/questionable/results

import ./serde/deserializer
import ./sandwiched # should not affect behavior, but does

let optionTypeActual = Option[UInt256].fromJson("30").tryGet.get

# The non-option-type call doesn't get contaminated, which suggests you need
# an indirection.
let bareTypeActual = UInt256.fromJson(newJString("30")).tryGet

let expected = 30.u256

echo "Expectation: should be ",  expected, " but is ", $optionTypeActual
echo "Expectation: should be ",  expected, " but is ", $bareTypeActual
echo if expected == optionTypeActual: "PASS" else: "FAIL"
