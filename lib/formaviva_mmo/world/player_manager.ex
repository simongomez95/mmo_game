defmodule FormavivaMmo.World.PlayerManager do

  def get_player(username) do
    Registry.lookup(FormavivaMmo.GameRegistry, username)
    |> assign_player(username)
  end

  def create_player(username) do
    {:ok, pid} = DynamicSupervisor.start_child(
      FormavivaMmo.GameSupervisor,
      {FormavivaMmo.Player.Player, name: {:via, Registry, {FormavivaMmo.GameRegistry, username}}}
    )
    pid
  end

  def assign_player([], username) do
    create_player(username)
  end

  def assign_player([{pid, _}], _) do
    pid
  end
end
