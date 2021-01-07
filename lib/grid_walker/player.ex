defmodule GridWalker.Player do
  use GenServer

  @walls [{1, 4}, {2, 4}, {3, 4}, {4, 4}, {4, 5}, {5, 5}]
  @rise_timeout 5000

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    grid_size = Application.get_env(:grid_walker, :grid_size)

    color = random_color()

    state = %{
      name: set_name(args[:name]),
      saved_color: color,
      current_color: color,
      position: args[:position] || random_position(grid_size, @walls),
      alive: true,
      grid_size: grid_size
    }

    {:ok, state}
  end

  def kill_player(pid) do
    GenServer.call(pid, :kill_player)
  end

  def get_player(nil) do
    :unknown_player
  end

  def get_player(pid) do
    GenServer.call(pid, :get_player)
  end

  def move(pid, direction) do
    GenServer.call(pid, {:move, direction})
  end

  def handle_call({:move, _}, _, %{alive: false} = state) do
    {:reply, :dead_player, state}
  end

  def handle_call({:move, direction}, _, state) do
    new_position = do_operation(direction, state.position, state.grid_size)
    {:reply, :ok, Map.put(state, :position, new_position)}
  end

  def handle_call(:kill_player, _, state) do
    Process.send_after(self(), :rise_player, @rise_timeout)

    new_state =
      state
      |> Map.put(:alive, false)
      |> Map.put(:current_color, "ffffff")

    {:reply, :ok, new_state}
  end

  def handle_call(:get_player, _, state) do
    player_data = %{
      name: state.name,
      color: state.current_color,
      alive: state.alive,
      position: %{
        x: elem(state.position, 0),
        y: elem(state.position, 1)
      }
    }

    {:reply, player_data, state}
  end

  def handle_info(:rise_player, state) do
    new_state =
      state
      |> Map.put(:alive, true)
      |> Map.put(:position, random_position(state.grid_size, @walls))
      |> Map.put(:current_color, state.saved_color)

    {:noreply, new_state}
  end

  defp do_operation("up", {x, y} = pos, grid_size) do
    update_position(pos, {x, y - 1}, grid_size)
  end

  defp do_operation("down", {x, y} = pos, grid_size) do
    update_position(pos, {x, y + 1}, grid_size)
  end

  defp do_operation("right", {x, y} = pos, grid_size) do
    update_position(pos, {x + 1, y}, grid_size)
  end

  defp do_operation("left", {x, y} = pos, grid_size) do
    update_position(pos, {x - 1, y}, grid_size)
  end

  defp update_position(current_pos, {x, y} = target_pos, {max_x, max_y})
       when target_pos in @walls or x >= max_x or y >= max_y or x < 0 or y < 0,
       do: current_pos

  defp update_position(_, target_pos, _grid_size),
    do: target_pos

  defp random_position({x, y}, walls) do
    new_pos = {Enum.random(0..(x - 1)), Enum.random(0..(y - 1))}

    if new_pos in walls do
      random_position({x, y}, walls)
    else
      new_pos
    end
  end

  defp random_color(), do: Enum.random(111_111..999_999)

  defp set_name(name) when name in ["", nil],
    do: "player_#{Enum.random(1..10)}#{Enum.random(1..10)}"

  defp set_name(name), do: name
end
