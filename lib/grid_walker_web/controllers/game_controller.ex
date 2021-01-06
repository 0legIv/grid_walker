defmodule GridWalkerWeb.GameController do
  use GridWalkerWeb, :controller

  alias GridWalker.Game

  def create(conn, params) do
    Game.add_player(params["current_player_name"])

    redirect(conn,
      to: Routes.game_path(conn, :index, current_player_name: params["current_player_name"])
    )
  end

  def operation(conn, params) do
    Game.perform_operation(params["current_player_name"], params["operation"])

    redirect(conn,
      to: Routes.game_path(conn, :index, current_player_name: params["current_player_name"])
    )
  end

  def index(conn, params) do
    players =
      Game.get_players()
      |> Jason.encode!(escape: :javascript_safe)

    current_player_name = params["current_player_name"]
    render(conn, "index.html", players: players, current_player_name: current_player_name)
  end
end
