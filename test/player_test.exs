defmodule PlayerTest do
  use ExUnit.Case

  test "initial position is 0,0" do
    {:ok, pid} = FormavivaMmo.Player.Player.start_link(name: {:via, Registry, {FormavivaMmo.GameRegistry, "player_1"}})

    assert {0,0} == FormavivaMmo.Player.Player.get_position(pid)
  end

  test "moves down to 1,0" do
    {:ok, pid} = FormavivaMmo.Player.Player.start_link(name: {:via, Registry, {FormavivaMmo.GameRegistry, "player_1"}})

    FormavivaMmo.Player.Player.move(pid, 'DOWN')

    assert {1,0} == FormavivaMmo.Player.Player.get_position(pid)
  end

  test "does not move is tile is not walkable" do
    {:ok, pid} = FormavivaMmo.Player.Player.start_link(name: {:via, Registry, {FormavivaMmo.GameRegistry, "player_1"}})

    FormavivaMmo.Player.Player.move(pid, 'RIGHT')

    assert {0,0} == FormavivaMmo.Player.Player.get_position(pid)
  end

  test "player kills enemy" do
    player_name = 'test_player_2'
    enemy_name = 'test_player_1'
    player_pid = FormavivaMmo.World.PlayerManager.get_player_pid(player_name)
    enemy_pid = FormavivaMmo.World.PlayerManager.get_player_pid(enemy_name)

    FormavivaMmo.Player.Player.attack(player_pid)
    :timer.sleep(5)
    
    assert FormavivaMmo.Player.Player.is_alive(enemy_pid) == false
  end


end
