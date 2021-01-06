use Mix.Config

config :grid_walker, GridWalkerWeb.Endpoint,
  http: [:inet6, port: 4000],
  url: [host: "localhost", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :logger, level: :info
