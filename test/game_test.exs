defmodule GridWalker.GameTest do
  use ExUnit.Case

  alias GridWalker.Game

  @player_name "test_player"

  test "add_player starts player process and saves it to the game state" do
    Game.add_player(@player_name)
    assert Game.get_player(@player_name) != :unknown_player
  end
end
