import pkg/questionable
import pkg/questionable/results
import pkg/stint
import pkg/chronicles except toJson

import ./stdjson
import ./parser

export stdjson
export chronicles

template expectJsonKind(
    expectedType: type, expectedKinds: set[JsonNodeKind], json: JsonNode
) =
  if json.isNil or json.kind notin expectedKinds:
    return failure(newException(
      ValueError, "Expected JSON of type " & $expectedType & " but got " & $json.kind
    ))

template expectJsonKind*(expectedType: type, expectedKind: JsonNodeKind, json: JsonNode) =
  expectJsonKind(expectedType, {expectedKind}, json)

proc fromJson*(T: typedesc[StUint or StInt], json: JsonNode): ?!T =
  static:
    echo "Instantiate serde fromJson StUint or StInt ", T

  echo "Dispatch to nim-serde"
  expectJsonKind(T, JString, json)
  let jsonStr = json.getStr
  let prefix =
    if jsonStr.len >= 2:
      jsonStr[0 .. 1]
    else:
      jsonStr
  case prefix
  of "0x":
    catch parse(jsonStr, T, 16)
  of "0o":
    catch parse(jsonStr, T, 8)
  of "0b":
    catch parse(jsonStr, T, 2)
  else:
    catch parse(jsonStr, T)

proc fromJson*[T](_: type Option[T], json: JsonNode): ?!Option[T] =
  static:
    echo "Instantiate serde fromJson Option[T] ", T

  if json.isNil or json.kind == JNull:
    return success(none T)
  without val =? T.fromJson(json), error:
    return failure(error)
  success(val.some)

proc fromJson*[T: ref object or object](_: type ?T, json: string): ?!Option[T] =
  static:
    echo "Instantiate serde fromJson ref object or object ", T

  when T is (StUInt or StInt):
    let jsn = newJString(json)
  else:
    let jsn = ?JsonNode.parse(json) # full qualification required in-module only
  Option[T].fromJson(jsn)

static: discard Option[UInt256].fromJson("")