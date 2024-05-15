
import pkg/json_rpc/rpcclient
import pkg/questionable 
import pkg/stint

# Puts both deserializers for UInt256 is scope so that the mixin binds to the 
# more specific one and alters behavior for clients.
import ./serde/deserializer
import ./ethers/conversions

proc sandwichOption*(client: RpcClient): ?UInt256 =
  var stream = unsafeMemoryInput("")
  type ReaderType = Reader(JrpcConv)
  var reader = init(ReaderType, stream, false, false)
  
  discard reader.readValue(typeof ?UInt256)
  
  result = UInt256.none

proc sandwichBare*(client: RpcClient): UInt256 =
  var stream = unsafeMemoryInput("")
  type ReaderType = Reader(JrpcConv)
  var reader = init(ReaderType, stream, false, false)
  
  discard reader.readValue(typeof UInt256)
  
  result = default(UInt256)