defmodule FormavivaMmo.Player.Player do
  @moduledoc """
  Module in charge of player functions
  """

  use GenServer

  @up "UP"
  @down "DOWN"
  @left "LEFT"
  @right "RIGHT"
  @attack "ATTACK"

  def start_link(options) do
    GenServer.start_link(__MODULE__, :ok, options)
  end

  def init(:ok) do
    {:ok, %{position: FormavivaMmo.World.GameMap.random_walkable_tile(), alive: true, last_death: 0}}
  end

  def is_alive(pid) when is_pid(pid) do
    GenServer.call(pid, :is_alive)
  end

  def is_alive(username) when is_binary(username) do
    FormavivaMmo.World.PlayerManager.get_player_pid(username) |> is_alive
  end

  def get_position(pid) do
    GenServer.call(pid, :get_position)
  end

  def max_distance({y1, x1}, {y2, x2}) do
    max(abs(y1 - y2), abs(x1 - x2))
  end

  def is_enemy_attackable(state, enemy_pid) do
    self_position = Map.get(state, :position)
    enemy_position = get_position(enemy_pid)
    max_distance(self_position, enemy_position) <= 1
  end

  def attacked(pid) do
    GenServer.cast(pid, :die)
    Task.start(fn -> revive(pid) end)
  end

  def revive(pid) do
    :timer.sleep(5000)
    GenServer.cast(pid, :revive)
  end

  def set_position(pid, {y, x}) do
    GenServer.cast(pid, {:set_position, {y, x}})
  end

  def attack(pid) do
    GenServer.cast(pid, :attack)
  end

  def move(pid, movement) do
    {y, x} = get_position(pid)
    if is_alive(pid) do
      case movement do
          @down -> set_position(pid, {y + 1, x})
          @up -> set_position(pid, {y - 1, x})
          @left -> set_position(pid, {y, x - 1})
          @right -> set_position(pid, {y, x + 1})
          @attack -> attack(pid)
      end
    end
  end

  def handle_call(:get_position, _from, state) do
    {:reply, Map.get(state, :position), state}
  end

  def handle_call(:is_alive, _from, state) do
    {:reply, Map.get(state, :alive), state}
  end

  def handle_cast({:set_position, {y, x}}, state) do
    if FormavivaMmo.World.GameMap.is_walkable({y, x}) do
        {:noreply, Map.put(state, :position, {y, x})}
    else
        {:noreply, state}
    end
  end

  def handle_cast(:attack, state) do
    other_players = List.delete(FormavivaMmo.World.PlayerManager.get_all_players(), self())
    attackable_players = Enum.filter(other_players, fn x -> is_enemy_attackable(state, x) end)
    Enum.each(attackable_players, fn x -> attacked(x) end)
    {:noreply, state}
  end

  def handle_cast(:die, state) do
    if Map.get(state, :alive) do
      {:noreply, Map.put(state, :alive, false)}
    else
      {:noreply, state}
    end
  end

  def handle_cast(:revive, state) do
    {:noreply, Map.put(state, :alive, true) |> Map.put(:position, FormavivaMmo.World.GameMap.random_walkable_tile())}
  end
end
