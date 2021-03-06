use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :derivco, DerivcoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :derivco, Derivco.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "derivco_user",
  password: "derivco_pass",
  database: "football",
  hostname: System.get_env("DB_IP"),
  pool: Ecto.Adapters.SQL.Sandbox

config :derivco, :protoTypes,
  divisions_seasons: "divisions_seasons",
  divisions_teams: "divisions_teams",
  seasons_teams: "seasons_teams",
  divisions: "divisions",
  seasons: "seasons",
  teams: "teams",
  matches: "matches"
