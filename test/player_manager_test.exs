defmodule PlayerManagerTest do
  use ExUnit.Case

  test "returns correct player pid" do
    test_name = 'test_player'
    {:ok, pid} = DynamicSupervisor.start_child(
      FormavivaMmo.GameSupervisor,
      {FormavivaMmo.Player.Player, name: {:via, Registry, {FormavivaMmo.GameRegistry, test_name}}}
    )

    assert pid == FormavivaMmo.World.PlayerManager.get_player(test_name)
  end

  test "creates new player" do
    test_name = 'test_player2'
    initial_len = length(DynamicSupervisor.which_children(FormavivaMmo.GameSupervisor))
    FormavivaMmo.World.PlayerManager.get_player(test_name)
    final_len = length(DynamicSupervisor.which_children(FormavivaMmo.GameSupervisor))
    assert initial_len + 1 == final_len
  end


end
