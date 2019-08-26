defmodule DerivcoWeb.TeamControllerTest do
  use DerivcoWeb.ConnCase
  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Messages.ResponseMessage

  describe "get all teams" do

    test "success request json", %{conn: conn} do

      {_status, team} = DerivcoDatabase.set_team(%{name: "La Coruna"})

      response =
        conn
        |> get(Routes.team_path(conn, :all))
        |> json_response(200)

      expected =[%{"name" => team.name, "id" => team.id}]

      assert response == expected
    end

    test "success request proto", %{conn: conn} do

      {_status, team} = DerivcoDatabase.set_team(%{name: "La Coruna"})

      response =
        conn
        |> get(Routes.team_path(conn, :all, [format: "protobuf"]))
        |> response(200)
        |> ResponseMessage.Response.decode()

      %Derivco.Messages.ResponseMessage.Response{teams: [teams]} = response
      expected = %Derivco.Messages.ResponseMessage.Teams{id: team.id, name: team.name}

      assert teams == expected
    end

    test "empty response", %{conn: conn} do

      response =
        conn
        |> get(Routes.team_path(conn, :all))
        |> json_response(200)

      expected = []

      assert response == expected
    end

  end

end
