defmodule FormavivaMmoWeb.PageView do
  use FormavivaMmoWeb, :view
  import FormavivaMmo.Utils

  def current_user(conn) do
    Plug.Conn.get_session(conn, :username)
  end

  def map_layout() do
    FormavivaMmo.World.GameMap.get_layout()
  end

  def players({y,x}) do
    FormavivaMmo.World.GameMap.get_players_in_tile({y,x})
    |> Enum.map(fn x -> FormavivaMmo.World.PlayerManager.get_player_name(x) end)
  end

end
