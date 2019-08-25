defmodule DerivcoWeb.ListControllerTest do
  use DerivcoWeb.ConnCase
  alias Derivco.Database.DerivcoDatabase

  describe "get divisions seasons" do

    test "success request", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, _division_season} = DerivcoDatabase.set_division_season(%{division_id: division.id, season_id: season.id})

      response =
        conn
        |> get(Routes.list_path(conn, :divisions_seasons))
        |> json_response(200)

      expected =[%{
        "division_name" => division.name,
        "division_id" => division.id,
        "season_name" => season.name,
        "season_id" => season.id
      }]

      assert response == expected
    end

    test "empty response", %{conn: conn} do

      response =
        conn
        |> get(Routes.list_path(conn, :divisions_seasons))
        |> json_response(200)

      expected =[]

      assert response == expected
    end

  end

  describe "get divisions_teams" do

    test "success request", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, team1} = DerivcoDatabase.set_team(%{name: "La Coruna"})
      {_status, team2} = DerivcoDatabase.set_team(%{name: "Eibar"})
      {_status, _match} =
        DerivcoDatabase.set_match(
          %{
            date: "19/08/2016",
            home_team_id: team1.id,
            away_team_id: team2.id,
            fthg: 0,
            ftag: 0,
            ftr: "H",
            hthg: 0,
            htag: 0,
            htr: "D",
            season_id: season.id,
            division_id: division.id
          })

      response =
        conn
        |> get(Routes.list_path(conn, :divisions_teams))
        |> json_response(200)

        expected =[%{
          "division_name" => division.name,
          "division_id" => division.id,
          "team_name" => team1.name,
          "team_id" => team1.id
        },
        %{
          "division_name" => division.name,
          "division_id" => division.id,
          "team_name" => team2.name,
          "team_id" => team2.id
        }]

      assert response == expected
    end

    test "empty response", %{conn: conn} do

      response =
        conn
        |> get(Routes.list_path(conn, :divisions_teams))
        |> json_response(200)

      expected = []

      assert response == expected
    end

  end

  describe "get seasons teams" do

    test "success request", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, team1} = DerivcoDatabase.set_team(%{name: "La Coruna"})
      {_status, team2} = DerivcoDatabase.set_team(%{name: "Eibar"})
      {_status, _match} =
        DerivcoDatabase.set_match(
          %{
            date: "19/08/2016",
            home_team_id: team1.id,
            away_team_id: team2.id,
            fthg: 0,
            ftag: 0,
            ftr: "H",
            hthg: 0,
            htag: 0,
            htr: "D",
            season_id: season.id,
            division_id: division.id
          })

      response =
        conn
        |> get(Routes.list_path(conn, :seasons_teams))
        |> json_response(200)

        expected =[%{
          "season_name" => season.name,
          "season_id" => season.id,
          "team_name" => team1.name,
          "team_id" => team1.id
        },
        %{
          "season_name" => season.name,
          "season_id" => season.id,
          "team_name" => team2.name,
          "team_id" => team2.id
        }]

      assert response == expected
    end

    test "empty response", %{conn: conn} do

      response =
        conn
        |> get(Routes.list_path(conn, :seasons_teams))
        |> json_response(200)

      expected = []

      assert response == expected
    end

  end

end
