defmodule DerivcoWeb.DivisionController do
  use DerivcoWeb, :controller

  alias Derivco.Database.DerivcoDatabase
  alias Derivco.Helpers.ResponseBuilder
  alias Derivco.Helpers.RequestFilter

  @protoTypes Application.get_env(:derivco, :protoTypes, []) |> Enum.into(%{})

  @doc """
  Controller of the option to get the list of all the divisions
  """
  def all(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_all_divisions(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:divisions])

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
  Controller of the option to get the list of the seasons likend with the given division
  """
  def linked_seasons(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_linked_seasons_with_division(filters)
        |> ResponseBuilder.create(filters, @protoTypes[:seasons])

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
  Controller of the option to get the list of the matches likend with the given division
  """
  def linked_matches(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_linked_matches_with_division(filters)
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
  Controller of the option to get the list of the matches likend with the given season division pair
  """
  def linked_seasons_matches(conn, params) do

    filters = RequestFilter.filter_request_params(params)
    if filters["status"] do
      {status, type, response} =
        DerivcoDatabase.get_linked_matches_with_divion_and_season(filters)
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
