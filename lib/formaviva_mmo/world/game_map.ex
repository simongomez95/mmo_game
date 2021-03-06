defmodule FormavivaMmo.World.GameMap do
  @moduledoc """
  This module defines the map layout and provides functions to interact with it
  """

  @layout [
    [1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1]
  ]

  def is_walkable({y, x}) do
    case FormavivaMmo.Utils.get_element(@layout, {y, x}) do
      1 -> false
      0 -> true
    end
  end

  def random_walkable_tile() do
    random_position = {:rand.uniform(length(@layout)) - 1, :rand.uniform(length(@layout)) - 1}
    if is_walkable(random_position) do
      random_position
    else
      random_walkable_tile()
    end
  end

  def get_layout do
    @layout
  end

  def get_players_in_tile({y, x}) do
    Enum.filter(FormavivaMmo.World.PlayerManager.get_all_players(), fn pid -> FormavivaMmo.Player.Player.get_position(pid) == {y, x} end)
  end
end
