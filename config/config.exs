# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :paper,
  ecto_repos: [Paper.Repo]

# Configures the endpoint
config :paper, PaperWeb.Endpoint,
  url: [host: System.get_env("HOST") || "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: PaperWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Paper.PubSub,
  live_view: [signing_salt: System.get_env("LIVE_VIEW_SALT")]

# Configure your database
config :paper, Paper.Repo,
  pool_size: System.get_env("DATABASE_POOL_SIZE") |> String.to_integer(),
  url: System.get_env("DATABASE_URL"),
  ssl: false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
