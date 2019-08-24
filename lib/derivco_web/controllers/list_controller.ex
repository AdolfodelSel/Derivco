defmodule DerivcoWeb.ListController do
  use DerivcoWeb, :controller

  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Helpers.ResponseBuilder
  alias Derivco.Helpers.RequestFilter

  @protoTypes Application.get_env(:derivco, :protoTypes, []) |> Enum.into(%{})

  @doc """
  Controller of the option to get the list of the divicion season pairs
  """
  def divisions_seasons(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_divisions_seasons(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:divisions_seasons])

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
  Controller of the option to get the list of the division team pairs
  """
  def divisions_teams(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_divisions_teams(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:divisions_teams])

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
  Controller of the option to get the list of the season team pairs
  """
  def seasons_teams(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_seasons_teams(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:seasons_teams])

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
