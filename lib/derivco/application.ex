defmodule Derivco.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Derivco.Repo,
      # Start the endpoint when the application starts
      DerivcoWeb.Endpoint,
      # Starts a worker by calling: Derivco.Worker.start_link(arg)
      worker(Derivco.Workers.DerivcoWorker, [])
    ]

    # Start the supervisor
    opts = [strategy: :one_for_one, name: Derivco.Supervisor]
    supervisor = Supervisor.start_link(children, opts)

    # Run the migrations
    path = Application.app_dir(:derivco, "priv/repo/migrations")
    Ecto.Migrator.run(Derivco.Repo, path, :up, all: true)

    Derivco.Workers.DerivcoWorker.populate_database()

    supervisor
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DerivcoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
