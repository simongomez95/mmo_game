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


end
