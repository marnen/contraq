use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :contraq, ContraqWeb.Endpoint,
  http: [port: 4001],
  server: true # TODO: should really be false except for white_bread

config :contraq, sql_sandbox: true

# Print only warnings and errors during test
config :logger, level: :info #:warn

# Configure your database
config :contraq, Contraq.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("APP_DB_USERNAME"),
  password: System.get_env("APP_DB_PASSWORD"),
  database: "contraq_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
