defmodule DerivcoWeb.MatchController do
  use DerivcoWeb, :controller

  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Helpers.ResponseBuilder
  alias Derivco.Helpers.RequestFilter

  @protoTypes Application.get_env(:derivco, :protoTypes, []) |> Enum.into(%{})

  @doc """
  Controller of the option to get the list of all the matches
  """
  def all(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_all_matches(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:matches])

      conn
        |> put_resp_header("content-type", type)
        |> send_resp(status, response)
    else
      conn
      |> put_status(400)
      |> json(%{errors: %{detail: "Bad request"}})
    end
  end

  @doc """
  Controller of the option to get the information of a specific match
  """
  def single_match(conn, params) do

    IO.inspect(conn)
    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_single_match(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:matches])

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
