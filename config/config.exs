# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :goreviewapi,
  ecto_repos: [Goreviewapi.Repo]

config :goreviewapi, Goreviewapi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :goreviewapi, GoreviewapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NctFjJisadQ/m90ycsZhU7+UlkHRxCR64cP9LhhGv4QJqtGgfWrr6OPj+wtwiaSO",
  render_errors: [view: GoreviewapiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Goreviewapi.PubSub,
  live_view: [signing_salt: "C88p6weY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
