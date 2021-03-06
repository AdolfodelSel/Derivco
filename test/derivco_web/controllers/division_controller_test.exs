defmodule DerivcoWeb.DivisionControllerTest do
  use DerivcoWeb.ConnCase
  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Messages.ResponseMessage

  describe "get all divisions" do

    test "success request json", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})

      response =
        conn
        |> get(Routes.division_path(conn, :all))
        |> json_response(200)

      expected =[%{"name" => division.name, "id" => division.id}]

      assert response == expected
    end

    test "success request proto", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})

      response =
        conn
        |> get(Routes.division_path(conn, :all, [format: "protobuf"]))
        |> response(200)
        |> ResponseMessage.Response.decode()

      %Derivco.Messages.ResponseMessage.Response{divisions: [divisions]} = response
      expected = %Derivco.Messages.ResponseMessage.Divisions{id: division.id, name: division.name}

      assert divisions == expected
    end

    test "empty response", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :all))
        |> json_response(200)

      expected = []

      assert response == expected
    end

  end

  describe "get linked seasons" do

    test "success request json", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, _division_season} = DerivcoDatabase.set_division_season(%{division_id: division.id, season_id: season.id})

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons, division.id))
        |> json_response(200)

      expected =[%{"name" => season.name, "id" => season.id}]

      assert response == expected
    end

    test "success request proto", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})
      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})
      {_status, _division_season} = DerivcoDatabase.set_division_season(%{division_id: division.id, season_id: season.id})

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons, division.id, [format: "protobuf"]))
        |> response(200)
        |> ResponseMessage.Response.decode()

      %Derivco.Messages.ResponseMessage.Response{seasons: [seasons]} = response
      expected = %Derivco.Messages.ResponseMessage.Seasons{id: season.id, name: season.name}

      assert seasons == expected
    end

    test "inexistent division", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons, 0))
        |> json_response(200)

      expected = []

      assert response == expected
    end

    test "wrong request", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons, "has to be an integer"))
        |> json_response(400)

      expected = %{"errors" => %{"detail" => "Bad request"} }

      assert response == expected
    end

  end

  describe "get linked matches" do

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
        |> get(Routes.division_path(conn, :linked_matches, division.id))
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
        |> get(Routes.division_path(conn, :linked_matches, division.id, [format: "protobuf"]))
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

    test "success request with params", %{conn: conn} do

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
            date: "19/08/2016",
            home_team_id: team1.id,
            away_team_id: team2.id,
            fthg: 1,
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
        |> get(Routes.division_path(conn, :linked_matches, division.id, [fthg: 1]))
        |> json_response(200)

      expected = [%{
        "id" => match2.id,
        "date" => "19/08/2016",
        "home_team" => team1.name,
        "away_team" => team2.name,
        "fthg" => 1,
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

    test "inexistent division", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :linked_matches, 0))
        |> json_response(200)

      expected = []

      assert response == expected
    end

    test "wrong request", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :linked_matches, "has to be an integer"))
        |> json_response(400)

      expected = %{"errors" => %{"detail" => "Bad request"} }

      assert response == expected
    end

  end

  describe "get linked seasons matches" do

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
        |> get(Routes.division_path(conn, :linked_seasons_matches, division.id, season.id))
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
        |> get(Routes.division_path(conn, :linked_seasons_matches, division.id, season.id, [format: "protobuf"]))
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

    test "success request with params", %{conn: conn} do

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
            date: "19/08/2016",
            home_team_id: team1.id,
            away_team_id: team2.id,
            fthg: 1,
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
        |> get(Routes.division_path(conn, :linked_seasons_matches, division.id, season.id, [fthg: 1]))
        |> json_response(200)

      expected =[%{
        "id" => match2.id,
        "date" => "19/08/2016",
        "home_team" => team1.name,
        "away_team" => team2.name,
        "fthg" => 1,
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

    test "inexistent division season", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons_matches, 0, 0))
        |> json_response(200)

      expected = []

      assert response == expected
    end

    test "inexistent division", %{conn: conn} do

      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons_matches, 0, season.id))
        |> json_response(200)

      expected = []

      assert response == expected
    end

    test "inexistent season", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons_matches, division.id, 0))
        |> json_response(200)

      expected = []

      assert response == expected
    end

    test "wrong request 1", %{conn: conn} do

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons_matches, "has to be an integer", "has to be an integer"))
        |> json_response(400)

      expected = %{"errors" => %{"detail" => "Bad request"} }

      assert response == expected
    end

    test "wrong request 2", %{conn: conn} do

      {_status, division} = DerivcoDatabase.set_division(%{name: "SP1"})

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons_matches, division.id, "has to be an integer"))
        |> json_response(400)

      expected = %{"errors" => %{"detail" => "Bad request"} }

      assert response == expected
    end

    test "wrong request 3", %{conn: conn} do

      {_status, season} = DerivcoDatabase.set_season(%{name: "201617"})

      response =
        conn
        |> get(Routes.division_path(conn, :linked_seasons_matches, "has to be an integer", season.id))
        |> json_response(400)

      expected = %{"errors" => %{"detail" => "Bad request"} }

      assert response == expected
    end

  end

end
