defmodule Derivco.Messages.ResponseMessage do
  @moduledoc """
  Used to charge the protobuf message structure.
  """
  use Protobuf, from: Path.expand("proto/response_message.proto", __DIR__)
end
