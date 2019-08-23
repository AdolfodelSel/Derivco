defmodule Derivco.Messages.ResponseMessage do
  use Protobuf, from: Path.expand("proto/response_message.proto", __DIR__)
end
