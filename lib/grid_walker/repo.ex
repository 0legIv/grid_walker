defmodule GridWalker.Repo do
  use Ecto.Repo,
    otp_app: :grid_walker,
    adapter: Ecto.Adapters.Postgres
end
