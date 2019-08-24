defmodule Derivco.Workers.DerivcoWorker do
  @moduledoc """
  Used to read and parse the data from the csv.
  It will create a new structure for the database handler for the population of the database.
  It has a dummy check just to not try to populate the database if this one has already data.
  """

  use GenServer

  require Logger
  alias Derivco.Database.DerivcoDatabase


  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: DerivcoWorker)
  end

  def init(state) do
    schedule(1000)
    {:ok, state}
  end

  def handle_info(:run, state) do

    try do
      continue = populate()
      if continue do
        schedule(1000)
      end
    rescue
      _ -> Logger.error(fn -> "Error in start: it couldn't apply migrations" end)
    end
    {:noreply, state}
  end

  defp schedule(refresh_time) do
    Process.send_after(self(), :run, refresh_time)
  end

  defp populate() do
    continue = DerivcoDatabase.dummyCheck()
    Logger.debug("populate: #{continue}")
    if continue do
      content = read_file()
      if !is_nil(content) do
        Logger.debug("populate: csv file content #{content}")
        all_data =
          String.split(content, ~r{(\n\r|\n)})
            |> List.delete_at(0)
            |> Enum.map(fn item ->
                splited_item = String.split(item, ",");
                %{
                  div: Enum.at(splited_item, 1),
                  season: Enum.at(splited_item, 2),
                  date: Enum.at(splited_item, 3),
                  home_team: Enum.at(splited_item, 4),
                  away_team: Enum.at(splited_item, 5),
                  fthg: Enum.at(splited_item, 6),
                  ftag: Enum.at(splited_item, 7),
                  ftr: Enum.at(splited_item, 8),
                  hthg: Enum.at(splited_item, 9),
                  htag: Enum.at(splited_item, 10),
                  htr: Enum.at(splited_item, 11)
                }
              end)
        divisions = get_item_list_from_data(all_data, :div)
        seasons = get_item_list_from_data(all_data, :season)
        teams = get_item_list_from_data(all_data, :home_team)
        status = DerivcoDatabase.populate_database(all_data, divisions, seasons, teams)
        Logger.debug("populate: the population of the database was #{status}")
        #If we had some error on the transaction we will try again
        !status
      else
        true
      end
   end
    continue
  end

  defp get_item_list_from_data(data, key) do

    {list, _acc} =
      Enum.map_reduce(data, [], fn(map, acc) ->
        item = map[key]
        case key do
          :season ->
            aux_item = item <> map[:div]
            if Enum.member?(acc, aux_item) do
              {nil, acc}
            else
              acc = acc ++ [aux_item]
              {%{name: item, division_id: map[:div]}, acc}
            end
          _ ->
            if Enum.member?(acc, item) do
              {nil, acc}
            else
              acc = acc ++ [item]
              {%{name: item}, acc}
            end
        end
      end)
    Enum.filter(list,fn(item) -> !is_nil(item) end)
  end

  defp read_file() do

    get_file_path()
      |> File.read()
      |> case do
        {:ok, content} ->
          content
        {:error, reason} ->
          Logger.error(fn -> "Error in read_file: #{reason}" end)
          nil
      end
  end

  defp get_file_path() do

    get_derivco_config_map()
    |> Map.get(:file_path, "")
  end

  defp get_derivco_config_map() do

    Application.get_env(:derivco, :csv, [])
    |> Enum.into(%{})
  end
end
