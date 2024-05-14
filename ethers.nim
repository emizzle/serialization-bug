import pkg/stint
import pkg/questionable/results
import pkg/json_rpc/jsonmarshal

import ./serde

proc fromJson*(_: typedesc[UInt256], json: JsonNode): ?!UInt256 =
  echo "Dispatch to nim-ethers"
  static:
    echo "Instantiate UInt256 nim-ethers"
    echo currentSourcePath()
  without result =? UInt256.fromHex(json.getStr()).catch, error:
    return UInt256.failure error.msg
  success result

proc readValue*[T: not JsonNode](
  r: var JsonReader[JrpcConv],
  result: var T) {.raises: [SerializationError, IOError].} =
  
  var json = r.readValue(JsonNode)
  result = T.fromJson(json).getOrRaise(SerializationError)
