defmodule FormavivaMmo.World.GameMap do

  @layout [
    [0,1,0],
    [0,0,0],
    [0,0,0]
  ]

  def is_walkable({y,x}) do
    case FormavivaMmo.Utils.get_element(@layout, {y,x}) do
      1 -> false
      0 -> true
    end
  end

  def get_layout do
    @layout
  end

  def get_players_in_tile({y,x}) do
    Enum.filter(FormavivaMmo.World.PlayerManager.get_all_players(), fn pid -> FormavivaMmo.Player.Player.get_position(pid) == {y,x} end)
  end
end
