defmodule Derivco.Helpers.ResponseBuilder do

  alias Derivco.Messages.ResponseMessage

  @protoTypes Application.get_env(:derivco, :protoTypes, []) |> Enum.into(%{})

  @doc """

  """
  def create(data, filters, protoType) do

    {type, response} =
      case filters["format"] do
        "protobuf" ->
          proto = build_proto(data, protoType)
          {"application/protobuf", proto}
        "json" ->
          {"application/json", Poison.encode!(data)}
        _ ->
          {"application/json", Poison.encode!(data)}
      end

    {200, type, response}
  end

  defp build_proto(data, protoType) do

    constructor =
      cond do
        @protoTypes[:divisions_seasons] == protoType ->
          %ResponseMessage.DivisionsSeasons{}
        @protoTypes[:divisions_teams] == protoType ->
          %ResponseMessage.DivisionsTeams{}
        @protoTypes[:seasons_teams] == protoType ->
          %ResponseMessage.SeasonsTeams{}
        @protoTypes[:divisions] == protoType ->
          %ResponseMessage.Divisions{}
        @protoTypes[:seasons] == protoType ->
          %ResponseMessage.Seasons{}
        @protoTypes[:teams] == protoType ->
          %ResponseMessage.Teams{}
        @protoTypes[:matches] == protoType ->
          %ResponseMessage.Matches{}
      end
    updated_data =
      Enum.map(data, fn item ->
        Map.merge(constructor, item)
      end)
    Map.put(%{}, String.to_atom(protoType), updated_data)
      |> ResponseMessage.Response.new()
      |> ResponseMessage.Response.encode()
  end
end
