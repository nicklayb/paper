# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :article,
  ecto_repos: [Article.Repo]

# Configures the endpoint
config :article, ArticleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kt8s9I1RiqB2pM6wz2Kym18s/rGQ7K2fNO6e7F6yKl2l0m6WpKzzCWRSc/Bl7JZx",
  render_errors: [view: ArticleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Article.PubSub,
  live_view: [signing_salt: "ep6HsSFN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
