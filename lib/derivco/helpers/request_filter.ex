defmodule Derivco.Helpers.RequestFilter do

  require Logger

  @doc """

  """
  def filter_request_params(params) do

    params_map =
      Enum.map(params, fn {key, value} ->
        result =
          case key do
            "name" ->
              check_field(key, value, 0, false)
            "division_id" ->
              check_field(key, value, 1, true)
              |> path_field()
            "season_id" ->
              check_field(key, value, 1, true)
              |> path_field()
            "match_id" ->
              check_field(key, value, 1, true)
              |> path_field()
            "format" ->
              if value in ["json", "protobuf"] do; value else "json" end
            "date" ->
              check_field(key, value, 0, false)
            "home_team_id" ->
              check_field(key, value, 0, true)
            "away_team_id" ->
              check_field(key, value, 0, true)
            "fthg" ->
              check_field(key, value, 0, true)
            "ftag" ->
              check_field(key, value, 0, true)
            "ftr" ->
              check_field(key, value, 0, false)
            "hthg" ->
              check_field(key, value, 0, true)
            "htag" ->
              check_field(key, value, 0, true)
            "htr" ->
              check_field(key, value, 0, false)
            _ ->
              false
          end
        {key, result}
      end)
      |> Map.new()
    index = Enum.find_index(params_map, fn {_key, value} -> value == nil end)
    if !is_nil(index) do
      %{"status" => false}
    else
      filters = normalize_filters(params_map)
      Map.merge(%{"status" => true}, filters)
    end
  end

  def check_field(key, value, max_length, is_integer) do

    try do
      list = String.split(value, ",")
      if length(list) <= max_length || max_length == 0 do
        Enum.each(list, fn x ->
          if is_integer do
            String.to_integer(x)
          else
            x
          end
        end)
        if Enum.at(list, 0) != "" do
          list
        else
          nil
        end
      else
        nil
      end
    rescue
      e in ArgumentError -> e
      Logger.error(fn -> "Argument error: #{key}" end)
      nil
    end
  end

  def path_field(value) do

    if !is_nil(value) do
      Enum.at(value, 0)
      |> String.to_integer()
    else
      nil
    end
  end

  defp normalize_filters(filters) do

    default_filters =  %{
      "name" => "(.*)",
      "date" => "(.*)",
      "home_team_id" => "(.*)",
      "away_team_id" => "(.*)",
      "fthg" => "(.*)",
      "ftag" => "(.*)",
      "ftr" => "(.*)",
      "hthg" => "(.*)",
      "htag" => "(.*)",
      "htr" => "(.*)"
    }
    Map.merge(default_filters, filters, fn _k, _v1, v2 ->
      if is_list(v2) do
        "(#{Enum.join(v2, "|")})"
      else
        "(#{v2})"
      end
    end)
  end
end
