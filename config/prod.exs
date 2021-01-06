use Mix.Config

config :grid_walker, GridWalkerWeb.Endpoint,
  http: [:inet6, port: 4000],
  url: [host: "${HOST}", port: 4000],
  code_reloader: false,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :logger, level: :info
