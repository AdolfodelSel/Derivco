defmodule DerivcoWeb.TeamController do
  use DerivcoWeb, :controller

  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Helpers.ResponseBuilder
  alias Derivco.Helpers.RequestFilter

  @protoTypes Application.get_env(:derivco, :protoTypes, []) |> Enum.into(%{})

  @doc """

  """
  def all(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_all_teams(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:teams])

      conn
        |> put_resp_header("content-type", type)
        |> send_resp(status, response)
    else
      conn
      |> put_status(400)
      |> json(%{errors: %{detail: "Bad request"}})
    end
  end
end
