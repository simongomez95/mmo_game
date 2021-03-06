defmodule FormavivaMmoWeb.PageView do
  use FormavivaMmoWeb, :view

  def current_user(conn) do
    Plug.Conn.get_session(conn, :username)
  end

  def map_layout() do
    FormavivaMmo.World.GameMap.get_layout()
  end

  def is_wall({y, x}) do
    !FormavivaMmo.World.GameMap.is_walkable({y, x})
  end

  def players({y, x}) do
    FormavivaMmo.World.GameMap.get_players_in_tile({y, x})
    |> Enum.map(fn x -> FormavivaMmo.World.PlayerManager.get_player_name(x) end)
  end

  def player_color(conn, player) do
    if player == current_user(conn) do
      if FormavivaMmo.Player.Player.is_alive(player) do
        "green"
      else
        "red"
      end
    else
      if FormavivaMmo.Player.Player.is_alive(player) do
        "yellow"
      else
        "grey"
      end
    end

  end

end
