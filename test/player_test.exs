defmodule PlayerTest do
  use ExUnit.Case

  test "moves down from 1,1 to 2,1" do
    {:ok, pid} = FormavivaMmo.Player.Player.start_link(name: {:via, Registry, {FormavivaMmo.GameRegistry, "player_1"}})

    FormavivaMmo.Player.Player.set_position(pid, {1,1})

    FormavivaMmo.Player.Player.move(pid, "DOWN")

    assert {2,1} == FormavivaMmo.Player.Player.get_position(pid)
  end

  test "does not move if tile is not walkable" do
    {:ok, pid} = FormavivaMmo.Player.Player.start_link(name: {:via, Registry, {FormavivaMmo.GameRegistry, "player_1"}})

    FormavivaMmo.Player.Player.set_position(pid, {1,1})

    FormavivaMmo.Player.Player.move(pid, "UP")

    assert {1,1} == FormavivaMmo.Player.Player.get_position(pid)
  end

  test "player kills enemy" do
    player_name = 'test_player_2'
    enemy_name = 'test_player_1'
    player_pid = FormavivaMmo.World.PlayerManager.get_player_pid(player_name)
    enemy_pid = FormavivaMmo.World.PlayerManager.get_player_pid(enemy_name)

    FormavivaMmo.Player.Player.set_position(player_pid, {1,1})
    FormavivaMmo.Player.Player.set_position(enemy_pid, {1,1})

    :timer.sleep(50)

    FormavivaMmo.Player.Player.attack(player_pid)
    :timer.sleep(50)

    assert FormavivaMmo.Player.Player.is_alive(enemy_pid) == false
  end


end
