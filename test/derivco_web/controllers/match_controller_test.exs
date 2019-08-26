defmodule DerivcoWeb.MatchControllerTest do
  use DerivcoWeb.ConnCase
  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Messages.ResponseMessage

  describe "get all matches" do

    test "success request json", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, team1} = DerivcoDatabase.set_team(%{name: "La Coruna"})
      {_status, team2} = DerivcoDatabase.set_team(%{name: "Eibar"})
      {_status, match} =
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
        |> get(Routes.match_path(conn, :all))
        |> json_response(200)

        expected =[%{
          "id" => match.id,
          "date" => "19/08/2016",
          "home_team" => team1.name,
          "away_team" => team2.name,
          "fthg" => 0,
          "ftag" => 0,
          "ftr" => "H",
          "hthg" => 0,
          "htag" => 0,
          "htr" => "D",
          "season" => season.name,
          "division" => division.name
        }]

      assert response == expected
    end

    test "success request proto", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, team1} = DerivcoDatabase.set_team(%{name: "La Coruna"})
      {_status, team2} = DerivcoDatabase.set_team(%{name: "Eibar"})
      {_status, match} =
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
        |> get(Routes.match_path(conn, :all, [format: "protobuf"]))
        |> response(200)
        |> ResponseMessage.Response.decode()

      %Derivco.Messages.ResponseMessage.Response{matches: [matches]} = response
      expected = %Derivco.Messages.ResponseMessage.Matches{
        id: match.id,
        date: "19/08/2016",
        home_team: team1.name,
        away_team: team2.name,
        fthg: 0,
        ftag: 0,
        ftr: "H",
        hthg: 0,
        htag: 0,
        htr: "D",
        season: season.name,
        division: division.name
      }

      assert matches == expected
    end

    test "empty response", %{conn: conn} do

      response =
        conn
        |> get(Routes.match_path(conn, :all))
        |> json_response(200)

      expected = []

      assert response == expected
    end

  end

  describe "get single match" do

    test "success request json", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, team1} = DerivcoDatabase.set_team(%{name: "La Coruna"})
      {_status, team2} = DerivcoDatabase.set_team(%{name: "Eibar"})
      {_status, _match1} =
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
      {_status, match2} =
        DerivcoDatabase.set_match(
          %{
            date: "20/08/2016",
            home_team_id: team2.id,
            away_team_id: team1.id,
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
        |> get(Routes.match_path(conn, :single_match, match2.id))
        |> json_response(200)

        expected =[%{
          "id" => match2.id,
          "date" => "20/08/2016",
          "home_team" => team2.name,
          "away_team" => team1.name,
          "fthg" => 0,
          "ftag" => 0,
          "ftr" => "H",
          "hthg" => 0,
          "htag" => 0,
          "htr" => "D",
          "season" => season.name,
          "division" => division.name
        }]

      assert response == expected
    end

    test "success request proto", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, team1} = DerivcoDatabase.set_team(%{name: "La Coruna"})
      {_status, team2} = DerivcoDatabase.set_team(%{name: "Eibar"})
      {_status, _match1} =
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
      {_status, match2} =
        DerivcoDatabase.set_match(
          %{
            date: "20/08/2016",
            home_team_id: team2.id,
            away_team_id: team1.id,
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
        |> get(Routes.match_path(conn, :single_match, match2.id, [format: "protobuf"]))
        |> response(200)
        |> ResponseMessage.Response.decode()

      %Derivco.Messages.ResponseMessage.Response{matches: [matches]} = response
      expected = %Derivco.Messages.ResponseMessage.Matches{
        id: match2.id,
        date: "20/08/2016",
        home_team: team2.name,
        away_team: team1.name,
        fthg: 0,
        ftag: 0,
        ftr: "H",
        hthg: 0,
        htag: 0,
        htr: "D",
        season: season.name,
        division: division.name
      }

      assert matches == expected
    end

    test "inexistent match", %{conn: conn} do

      response =
        conn
        |> get(Routes.match_path(conn, :single_match, 0))
        |> json_response(200)

      expected = []

      assert response == expected
    end

    test "wrong request", %{conn: conn} do

      response =
        conn
        |> get(Routes.match_path(conn, :single_match, "has to be an integer"))
        |> json_response(400)

      expected = %{"errors" => %{"detail" => "Bad request"} }

      assert response == expected
    end

  end
end
