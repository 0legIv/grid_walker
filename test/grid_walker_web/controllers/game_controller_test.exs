defmodule GridWalker.GameControllerTest do
  use GridWalkerWeb.ConnCase, async: false

  alias GridWalker.Game

  test "can create player", %{conn: conn} do
    player_name = "player1"
    params = %{"current_player_name" => player_name}

    conn = post(conn, Routes.game_path(conn, :create, params))
    assert get_flash(conn, :info) == "Player created"
    assert Game.get_player(player_name) != :unknown_player
  end
end
