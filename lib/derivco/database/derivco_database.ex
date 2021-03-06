defmodule Derivco.Database.DerivcoDatabase do

  require Logger
  import Ecto.Query
  alias Derivco.Repo
  alias Derivco.Models.{Division, Season, Match, Team, DivisionSeason}

  @regexp "? REGEXP ?"

  @doc """
  Dummy test to check if the database has any value.
  """
  def dummyCheck() do
    from(m in Division)
    |> limit(1)
    |> Repo.one()
    |> case do
      nil ->
        true
      _ ->
        false
      end
  end

  @doc """
  To get the list of the division season pairs
  """
  def get_divisions_seasons(_filters) do

    from(d in Division)
    |> join(:inner, [d], ds in DivisionSeason, ds.division_id == d.id)
    |> join(:inner, [d,ds], s in Season, s.id == ds.season_id)
    |> select([d,ds,s], %{division_id: d.id, division_name: d.name, season_id: s.id, season_name: s.name})
    |> Repo.all()
  end

  @doc """
  To get the list of the division team pairs
  """
  def get_divisions_teams(_filters) do

    from(d in Division)
    |> join(:inner, [d], m in Match, m.division_id == d.id)
    |> join(:inner, [d,m], t in Team, t.id == m.home_team_id or t.id == m.away_team_id)
    |> distinct(true)
    |> select([d,m,t], %{division_id: d.id, division_name: d.name, team_id: t.id, team_name: t.name})
    |> Repo.all()
  end

  @doc """
  To get the list of the season team pairs
  """
  def get_seasons_teams(_filters) do

    from(s in Season)
    |> join(:inner, [s], m in Match, m.season_id == s.id)
    |> join(:inner, [s,m], t in Team, t.id == m.home_team_id or t.id == m.away_team_id)
    |> distinct(true)
    |> select([s,m,t], %{season_id: s.id, season_name: s.name, team_id: t.id, team_name: t.name})
    |> Repo.all()
  end

  @doc """
  To get the list of all the divisions
  """
  def get_all_divisions(_filters) do

    from(d in Division)
      |> select([d], %{id: d.id, name: d.name})
      |> Repo.all()
  end

  @doc """
  To get the list of the seasons linked with the given division
  """
  def get_linked_seasons_with_division(filters) do

    from(ds in DivisionSeason)
    |> where([ds], ds.division_id == ^filters["division_id"])
    |> join(:inner, [ds], s in Season, s.id == ds.season_id)
    |> select([ds,s], %{id: s.id, name: s.name})
    |> Repo.all()
  end

  @doc """
  To get the list of the matches linked with the given division
  """
  def get_linked_matches_with_division(filters) do

    from(m in Match)
    |> where([m],
      m.division_id == ^filters["division_id"]
      and fragment(@regexp, m.date, ^filters["date"])
      and fragment(@regexp, m.home_team_id, ^filters["home_team_id"])
      and fragment(@regexp, m.away_team_id, ^filters["away_team_id"])
      and fragment(@regexp, m.fthg, ^filters["fthg"])
      and fragment(@regexp, m.ftag, ^filters["ftag"])
      and fragment(@regexp, m.ftr, ^filters["ftr"])
      and fragment(@regexp, m.hthg, ^filters["hthg"])
      and fragment(@regexp, m.htag, ^filters["htag"])
      and fragment(@regexp, m.htr, ^filters["htr"])
    )
    |> join(:inner, [m], d in Division, m.division_id == d.id)
    |> join(:inner, [m,d], s in Season, m.season_id == s.id)
    |> join(:inner, [m,d,s], t1 in Team, m.home_team_id == t1.id)
    |> join(:inner, [m,d,s,t1], t2 in Team, m.away_team_id == t2.id)
    |> select([m,d,s,t1,t2], %{
        id: m.id,
        date: m.date,
        home_team: t1.name,
        away_team: t2.name,
        fthg: m.fthg,
        ftag: m.ftag,
        ftr: m.ftr,
        hthg: m.hthg,
        htag: m.htag,
        htr: m.htr,
        season: s.name,
        division: d.name
      })
    |> Repo.all()
  end

  @doc """
  To get the list of the matches linked with the given season division pair
  """
  def get_linked_matches_with_divion_and_season(filters) do

    from(m in Match)
    |> where([m],
      m.division_id == ^filters["division_id"]
      and m.season_id == ^filters["season_id"]
      and fragment(@regexp, m.date, ^filters["date"])
      and fragment(@regexp, m.home_team_id, ^filters["home_team_id"])
      and fragment(@regexp, m.away_team_id, ^filters["away_team_id"])
      and fragment(@regexp, m.fthg, ^filters["fthg"])
      and fragment(@regexp, m.ftag, ^filters["ftag"])
      and fragment(@regexp, m.ftr, ^filters["ftr"])
      and fragment(@regexp, m.hthg, ^filters["hthg"])
      and fragment(@regexp, m.htag, ^filters["htag"])
      and fragment(@regexp, m.htr, ^filters["htr"])
    )
    |> join(:inner, [m], d in Division, m.division_id == d.id)
    |> join(:inner, [m,d], s in Season, m.season_id == s.id)
    |> join(:inner, [m,d,s], t1 in Team, m.home_team_id == t1.id)
    |> join(:inner, [m,d,s,t1], t2 in Team, m.away_team_id == t2.id)
    |> select([m,d,s,t1,t2], %{
      id: m.id,
      date: m.date,
      home_team: t1.name,
      away_team: t2.name,
      fthg: m.fthg,
      ftag: m.ftag,
      ftr: m.ftr,
      hthg: m.hthg,
      htag: m.htag,
      htr: m.htr,
      season: s.name,
      division: d.name
    })
    |> Repo.all()
  end

  @doc """
  To get the list of all the seasons
  """
  def get_all_seasons(_filters) do

    from(s in Season)
    |> select([s], %{id: s.id, name: s.name})
    |> Repo.all()
  end

  @doc """
  To get the list of the divisions linked with the given season
  """
  def get_linked_divisions_with_season(filters) do

    from(ds in DivisionSeason)
    |> where([ds], ds.season_id == ^filters["season_id"])
    |> join(:inner, [ds], d in Division, d.id == ds.division_id)
    |> select([ds,d], %{id: d.id, name: d.name})
    |> Repo.all()
  end

  @doc """
  To get the list of the matches linked with the given season
  """
  def get_linked_matches_with_season(filters) do

    from(m in Match)
    |> where([m],
      m.season_id == ^filters["season_id"]
      and fragment(@regexp, m.date, ^filters["date"])
      and fragment(@regexp, m.home_team_id, ^filters["home_team_id"])
      and fragment(@regexp, m.away_team_id, ^filters["away_team_id"])
      and fragment(@regexp, m.fthg, ^filters["fthg"])
      and fragment(@regexp, m.ftag, ^filters["ftag"])
      and fragment(@regexp, m.ftr, ^filters["ftr"])
      and fragment(@regexp, m.hthg, ^filters["hthg"])
      and fragment(@regexp, m.htag, ^filters["htag"])
      and fragment(@regexp, m.htr, ^filters["htr"])
    )
    |> join(:inner, [m], d in Division, m.division_id == d.id)
    |> join(:inner, [m,d], s in Season, m.season_id == s.id)
    |> join(:inner, [m,d,s], t1 in Team, m.home_team_id == t1.id)
    |> join(:inner, [m,d,s,t1], t2 in Team, m.away_team_id == t2.id)
    |> select([m,d,s,t1,t2], %{
        id: m.id,
        date: m.date,
        home_team: t1.name,
        away_team: t2.name,
        fthg: m.fthg,
        ftag: m.ftag,
        ftr: m.ftr,
        hthg: m.hthg,
        htag: m.htag,
        htr: m.htr,
        season: s.name,
        division: d.name
      })
    |> Repo.all()
  end

  @doc """
  To get the list of all the teams
  """
  def get_all_teams(_filters) do

    from(t in Team)
    |> select([t], %{id: t.id, name: t.name})
    |> Repo.all()
  end

  @doc """
  To get the list of all the matches
  """
  def get_all_matches(filters) do

    from(m in Match)
    |> where([m],
      fragment(@regexp, m.date, ^filters["date"])
      and fragment(@regexp, m.home_team_id, ^filters["home_team_id"])
      and fragment(@regexp, m.away_team_id, ^filters["away_team_id"])
      and fragment(@regexp, m.fthg, ^filters["fthg"])
      and fragment(@regexp, m.ftag, ^filters["ftag"])
      and fragment(@regexp, m.ftr, ^filters["ftr"])
      and fragment(@regexp, m.hthg, ^filters["hthg"])
      and fragment(@regexp, m.htag, ^filters["htag"])
      and fragment(@regexp, m.htr, ^filters["htr"])
    )
    |> join(:inner, [m], d in Division, m.division_id == d.id)
    |> join(:inner, [m,d], s in Season, m.season_id == s.id)
    |> join(:inner, [m,d,s], t1 in Team, m.home_team_id == t1.id)
    |> join(:inner, [m,d,s,t1], t2 in Team, m.away_team_id == t2.id)
    |> select([m,d,s,t1,t2], %{
        id: m.id,
        date: m.date,
        home_team: t1.name,
        away_team: t2.name,
        fthg: m.fthg,
        ftag: m.ftag,
        ftr: m.ftr,
        hthg: m.hthg,
        htag: m.htag,
        htr: m.htr,
        season: s.name,
        division: d.name
      })
    |> Repo.all()
  end

  @doc """
  To get the information of a specific match
  """
  def get_single_match(filters) do

    from(m in Match)
    |> where([m], m.id == ^filters["match_id"])
    |> join(:inner, [m], d in Division, m.division_id == d.id)
    |> join(:inner, [m,d], s in Season, m.season_id == s.id)
    |> join(:inner, [m,d,s], t1 in Team, m.home_team_id == t1.id)
    |> join(:inner, [m,d,s,t1], t2 in Team, m.away_team_id == t2.id)
    |> select([m,d,s,t1,t2], %{
        id: m.id,
        date: m.date,
        home_team: t1.name,
        away_team: t2.name,
        fthg: m.fthg,
        ftag: m.ftag,
        ftr: m.ftr,
        hthg: m.hthg,
        htag: m.htag,
        htr: m.htr,
        season: s.name,
        division: d.name
      })
    |> Repo.all()
  end

  @doc """
  Populate the database with the given information
  """
  def populate_database(all_data, divisions, seasons, teams) do

    {inserted_divisions, inserted_divisions_status} = insert_items(divisions, Division)
    if inserted_divisions_status do
      {inserted_seasons, inserted_seasons_status} = insert_items(seasons, Season)
      if inserted_seasons_status do
        aux_division_season =
          Enum.map(seasons, fn season ->
            index = Enum.find_index(inserted_divisions, fn(x) -> x[:name] == season[:division_id] end)
            if !is_nil(index) do
              division_id = Enum.at(inserted_divisions, index)[:id]
              Map.replace!(season, :division_id, division_id)
            else
              season
            end
          end)
          |> Enum.map(fn aux_season ->
              index = Enum.find_index(inserted_seasons, fn(x) -> x[:name] == aux_season[:name] end)
              if !is_nil(index) do
                season_id = Enum.at(inserted_seasons, index)[:id]
                Map.put(aux_season, :season_id, season_id)
                |> Map.delete(:name)
              else
                aux_season
              end
            end)
        {_inserted_division_season, inserted_division_season_status} = insert_items(aux_division_season, DivisionSeason)
        if inserted_division_season_status do
          {inserted_teams, inserted_teams_status} = insert_items(teams, Team)
          if inserted_teams_status do
            aux_matches =
              Enum.map(all_data, fn match ->
                index_division = Enum.find_index(inserted_divisions, fn(x) -> x[:name] == match[:div] end)
                index_season = Enum.find_index(inserted_seasons, fn(x) -> x[:name] == match[:season] end)
                index_home_team = Enum.find_index(inserted_teams, fn(x) -> x[:name] == match[:home_team] end)
                index_away_team = Enum.find_index(inserted_teams, fn(x) -> x[:name] == match[:away_team] end)
                if !is_nil(index_season) && !is_nil(index_home_team) && !is_nil(index_away_team) && !is_nil(index_division) do
                  division_id = Enum.at(inserted_divisions, index_division)[:id]
                  season_id = Enum.at(inserted_seasons, index_season)[:id]
                  home_team_id = Enum.at(inserted_teams, index_home_team)[:id]
                  away_team_id = Enum.at(inserted_teams, index_away_team)[:id]
                  %{
                    date: match[:date],
                    home_team_id: home_team_id,
                    away_team_id: away_team_id,
                    fthg: match[:fthg],
                    ftag: match[:ftag],
                    ftr: match[:ftr],
                    hthg: match[:hthg],
                    htag: match[:htag],
                    htr: match[:htr],
                    season_id: season_id,
                    division_id: division_id
                  }
                else
                  match
                end
              end)
            {_inserted_matches, inserted_matches_status} = insert_items(aux_matches, Match)
            inserted_matches_status
          else
            false
          end
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  @doc """
  To store an specific division on the database, it is using on testing
  """
  def set_division(data) do

    Division.changeset(%Division{}, data)
    |> Repo.insert()
    |> case do
      {:ok, result} ->
        {true, result}
      {:error, changeset} ->
        Logger.error(fn -> "Error in set_division: couldnt insert #{data[:name]}" end)
        {false, changeset}
    end
  end

  @doc """
  To store an specific season on the database, it is using on testing
  """
  def set_season(data) do

    Season.changeset(%Season{}, data)
    |> Repo.insert()
    |> case do
      {:ok, result} ->
        {true, result}
      {:error, changeset} ->
        Logger.error(fn -> "Error in set_season: couldnt insert #{data[:name]}" end)
        {false, changeset}
    end
  end

  @doc """
  To store an specific division season pair on the database, it is using on testing
  """
  def set_division_season(data) do

    DivisionSeason.changeset(%DivisionSeason{}, data)
    |> Repo.insert()
    |> case do
      {:ok, result} ->
        {true, result}
      {:error, changeset} ->
        Logger.error(fn -> "Error in set_division_season" end)
        {false, changeset}
    end
  end

  @doc """
  To store an specific match on the database, it is using on testing
  """
  def set_match(data) do

    Match.changeset(%Match{}, data)
    |> Repo.insert()
    |> case do
      {:ok, result} ->
        {true, result}
      {:error, changeset} ->
        Logger.error(fn -> "Error in set_match: couldnt insert #{data[:name]}" end)
        {false, changeset}
    end
  end

  @doc """
  To store an specific team on the database, it is using on testing
  """
  def set_team(data) do

    Team.changeset(%Team{}, data)
    |> Repo.insert()
    |> case do
      {:ok, result} ->
        {true, result}
      {:error, changeset} ->
        Logger.error(fn -> "Error in set_team: couldnt insert #{data[:name]}" end)
        {false, changeset}
    end
  end

  defp insert_items(items, model) do
    Repo.transaction(fn ->
      {inserted_items, _acc} =
        Enum.map_reduce(items, 0, fn(map, acc) ->
          data =
            case model do
              Match ->
                from(m in Match, where: m.home_team_id == ^map[:home_team_id] and m.away_team_id == ^map[:away_team_id] and m.season_id == ^map[:season_id])
                |> Repo.one
              DivisionSeason ->
                from(ds in DivisionSeason, where: ds.season_id == ^map[:season_id] and ds.division_id == ^map[:division_id])
                |> Repo.one
              _ ->
                Repo.get_by(model, name: map[:name])
            end
          case data do
            nil ->
              model.changeset(model.get_empty_map(), map)
              |> Repo.insert()
              |> case do
                  {:ok, result} ->
                    {Map.merge(map, %{id: result.id}), acc}
                  {:error, _changeset} ->
                    Logger.error(fn -> "Error in populate_database: couldnt insert #{map[:name]}" end)
                    {nil, acc}
                end
            %Division{id: division_id} ->
              {Map.merge(map, %{id: division_id}), acc}
            %Season{id: season_id} ->
              {Map.merge(map, %{id: season_id}), acc}
            %Team{id: team_id} ->
              {Map.merge(map, %{id: team_id}), acc}
            %Match{id: match_id} ->
              {Map.merge(map, %{id: match_id}), acc}
            %DivisionSeason{id: division_seasons_id} ->
              {Map.merge(map, %{id: division_seasons_id}), acc}
          end
        end)
      inserted_items
      end)
      |> case do
        {:ok, inserted_items} ->
          {inserted_items, true}
        {:error, _error} ->
          {"", false}
      end
  end
end
