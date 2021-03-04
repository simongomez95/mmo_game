defmodule FormavivaMmoWeb.PageController do
  use FormavivaMmoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def game(conn, %{"name" => username}) do
    FormavivaMmo.World.PlayerManager.get_player_pid(username)
    put_session(conn, :username, username) |> render("game.html")
  end

  def game(conn, %{}) do
    username = get_session(conn, :username)
    if username do
      FormavivaMmo.World.PlayerManager.get_player_pid(username)
      render(conn, "game.html")
    else
      put_session(conn, :username, FormavivaMmo.Utils.generate_username())
      |> render("game.html")
    end
  end

  def move(conn, %{"movement" => movement}) do
    pid = get_session(conn, :username) |> FormavivaMmo.World.PlayerManager.get_player_pid
    FormavivaMmo.Player.Player.move(pid, movement)
    render(conn, "game.html")
  end
end
