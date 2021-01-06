# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :grid_walker, GridWalkerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GgXo0SwLtvX9NGjiREn+oPpC6Hd5uYNMocSw+7f4Hn8wLpltNaZGR0RXpqoMH4qZ",
  render_errors: [view: GridWalkerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GridWalker.PubSub,
  live_view: [signing_salt: "BVcQlhfK"]

config :grid_walker,
  grid_size: {8, 8}

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
