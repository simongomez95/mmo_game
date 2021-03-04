defmodule FormavivaMmo.World.PlayerManager do

  def get_player_pid(username) do
    Registry.lookup(FormavivaMmo.GameRegistry, username)
    |> assign_player(username)
  end

  def get_player_name(pid) do
    [name] = Registry.keys(FormavivaMmo.GameRegistry, pid)
    name
  end

  def create_player(username) do
    {:ok, pid} = DynamicSupervisor.start_child(
      FormavivaMmo.GameSupervisor,
      {FormavivaMmo.Player.Player, name: {:via, Registry, {FormavivaMmo.GameRegistry, username}}}
    )
    pid
  end

  def get_pid_from_child(child) do
    {_, pid, _, _} = child
    pid
  end

  def assign_player([], username) do
    create_player(username)
  end

  def assign_player([{pid, _}], _) do
    pid
  end

  def get_all_players() do
    children = DynamicSupervisor.which_children(FormavivaMmo.GameSupervisor)
    Enum.map(children, fn x -> get_pid_from_child x end)
  end
end
