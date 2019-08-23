use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :derivco, DerivcoWeb.Endpoint,
  secret_key_base: "6gJN16fNpzMb7D1wz9fscMItTnV1X7XFa5uxzvAB7iUwVC/dJQ/wNyg3sRdfLlHp"

# Configure your database
config :derivco, Derivco.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "derivco_user",
  password: "derivco_pass",
  database: "football",
  pool_size: 10,
  pool_timeout: :infinity,
  timeout: :infinity
