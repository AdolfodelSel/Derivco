defmodule DerivcoWeb.TeamControllerTest do
  use DerivcoWeb.ConnCase
  alias Derivco.Database.DerivcoDatabase

  describe "get all teams" do

    test "success request", %{conn: conn} do

      {_status, team} = DerivcoDatabase.set_team(%{name: "La Coruna"})

      response =
        conn
        |> get(Routes.team_path(conn, :all))
        |> json_response(200)

      expected =[%{"name" => team.name, "id" => team.id}]

      assert response == expected
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
