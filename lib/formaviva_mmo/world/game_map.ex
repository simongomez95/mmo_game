defmodule FormaVivaMmo.World.GameMap do

  @layout [
    [0,1,0],
    [0,0,0],
    [0,0,0]
  ]

  def get_tile(matrix, {y,x}) do
    Enum.at(Enum.at(matrix, y), x)
  end

  def is_walkable({y,x}) do
    case get_tile(@layout, {y,x}) do
      1 -> false
      0 -> true
    end
  end
end
