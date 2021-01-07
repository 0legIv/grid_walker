defmodule GridWalker.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      GridWalkerWeb.Telemetry,
      GridWalker.Game,
      {Phoenix.PubSub, name: GridWalker.PubSub},
      GridWalkerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: GridWalker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    GridWalkerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
