# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :contraq,
  ecto_repos: [Contraq.Repo]

# Configures the endpoint
config :contraq, ContraqWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+pG2y3Laq8XUZFH3IYaXmQXJeEE8KuG9caKpIBaPo85NhcParJ9fVLJPQGZ5gv3Y",
  render_errors: [view: ContraqWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Contraq.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :contraq, ContraqWeb,
  datetime_format: "{D} {Mshort} {YYYY} {h24}:{m}",
  date_format: "{D} {Mshort} {YYYY}"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines, haml: PhoenixHaml.Engine

config :white_bread,
  outputers: [{WhiteBread.Outputers.Console, []},
              {WhiteBread.Outputers.HTML, path: "#{__DIR__}/../whitebread_report.html"},
              # {WhiteBread.Outputers.JSON, path: "~/build/whitebread_report.json"}
             ]

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Contraq.Coherence.User,
  repo: Contraq.Repo,
  module: Contraq,
  web_module: ContraqWeb,
  router: ContraqWeb.Router,
  messages_backend: ContraqWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:trackable, :rememberable, :recoverable, :registerable, :authenticatable]

config :coherence, ContraqWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
