defmodule GridWalker.PlayerTest do
  use ExUnit.Case

  alias GridWalker.Player

  setup do
    {:ok, pid} = Player.start_link(name: "test_player", position: {2, 1})
    %{player_pid: pid}
  end

  test "kill_player/1 changes color and disables actions for player", %{player_pid: pid} do
    Player.kill_player(pid)
    player = Player.get_player(pid)
    assert player.alive == false
    assert player.color == "ffffff"

    assert Player.move(pid, "up") == :dead_player
  end

  test "move/2 changes the coordinate of the player", %{player_pid: pid} do
    player_initial = Player.get_player(pid)
    Player.move(pid, "up")
    player_move1 = Player.get_player(pid)
    assert player_initial.position.y - 1 == player_move1.position.y

    Player.move(pid, "down")
    player_move2 = Player.get_player(pid)
    assert player_initial.position.y == player_move2.position.y

    Player.move(pid, "left")
    player_move3 = Player.get_player(pid)
    assert player_initial.position.x - 1 == player_move3.position.x

    Player.move(pid, "right")
    player_move4 = Player.get_player(pid)
    assert player_initial.position.x == player_move4.position.x
  end
end
