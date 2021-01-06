defmodule GridWalker.Game do
  use GenServer

  alias GridWalker.Player

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    DynamicSupervisor.start_link(strategy: :one_for_one, name: PlayerSupervisor)

    state = %{
      players: %{}
    }

    {:ok, state}
  end

  def perform_operation(name, operation) do
    GenServer.call(__MODULE__, {:perform_operation, name, operation})
  end

  def add_player(name) do
    GenServer.call(__MODULE__, {:add_player, name})
  end

  def get_player(name) do
    GenServer.call(__MODULE__, {:get_player, name})
  end

  def get_players() do
    GenServer.call(__MODULE__, :get_players)
  end

  def handle_call({:perform_operation, name, "attack"}, _, state) do
    players =
      state.players
      |> do_get_players()
      |> Enum.reduce(%{enemies: [], attacker: nil}, fn player, acc ->
        if player.name == name do
          Map.put(acc, :attacker, player)
        else
          Map.put(acc, :enemies, [player | acc.enemies])
        end
      end)

    Enum.each(players.enemies, fn enemy ->
      if players.attacker.position.x <= enemy.position.x + 1 and
           players.attacker.position.x >= enemy.position.x - 1 and
           players.attacker.position.y <= enemy.position.y + 1 and
           players.attacker.position.y >= enemy.position.y - 1 do
        Player.kill_player(state.players[enemy.name])
      end
    end)

    {:reply, :ok, state}
  end

  def handle_call({:perform_operation, name, operation}, _, state) do
    player = Map.get(state.players, name)
    Player.move(player, operation)
    {:reply, :ok, state}
  end

  def handle_call(:get_players, _, state) do
    players = do_get_players(state.players)

    {:reply, players, state}
  end

  def handle_call({:get_player, name}, _, state) do
    player =
      state.players
      |> Map.get(name)
      |> Player.get_player()

    {:reply, player, state}
  end

  def handle_call({:add_player, name}, _, state) do
    if Enum.any?(state.players, fn {player_name, _} -> player_name == name end) do
      {:reply, :ok, state}
    else
      {:ok, pid} = DynamicSupervisor.start_child(PlayerSupervisor, {Player, [name: name]})
      new_players = Map.put(state.players, name, pid)
      {:reply, :ok, Map.put(state, :players, new_players)}
    end
  end

  defp do_get_players(players) do
    players
    |> Enum.map(fn {_name, pid} ->
      Player.get_player(pid)
    end)
  end
end
