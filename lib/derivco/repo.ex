defmodule Derivco.Repo do
  use Ecto.Repo,
    otp_app: :derivco,
    adapter: Ecto.Adapters.MySQL
end
