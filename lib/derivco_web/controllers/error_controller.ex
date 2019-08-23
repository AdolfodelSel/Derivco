defmodule DerivcoWeb.ErrorController do
  use DerivcoWeb, :controller

  @doc """

  """
  def four_oh_oh(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{errors: %{detail: "Bad request"}})
  end

  @doc """

  """
  def four_oh_four(conn, _params) do
    conn
    |> put_status(404)
    |> json(%{errors: %{detail: "Endpoint not found"}})
  end

  @doc """

  """
  def five_oh_oh(conn, _params) do
    conn
    |> put_status(500)
    |> json(%{errors: %{detail: "Internal server error"}})
  end

end
