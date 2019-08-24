defmodule DerivcoWeb.ErrorController do
  use DerivcoWeb, :controller

  @doc """
  Response for bad requests
  """
  def four_oh_oh(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{errors: %{detail: "Bad request"}})
  end

  @doc """
  Response for unknown urls
  """
  def four_oh_four(conn, _params) do
    conn
    |> put_status(404)
    |> json(%{errors: %{detail: "Endpoint not found"}})
  end

  @doc """
  Response for internal server erros
  """
  def five_oh_oh(conn, _params) do
    conn
    |> put_status(500)
    |> json(%{errors: %{detail: "Internal server error"}})
  end

end
