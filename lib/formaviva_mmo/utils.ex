defmodule FormavivaMmo.Utils do
  @moduledoc """
  Provides various utilitary functions
  """
  def generate_username() do
    min = String.to_integer("100000", 36)
    max = String.to_integer("ZZZZZZ", 36)

    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
    |> Integer.to_string(36)
  end

  def get_element(matrix, {y, x}) do
    Enum.at(Enum.at(matrix, y), x)
  end
end
