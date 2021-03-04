defmodule FormavivaMmoWeb.PageController do
  use FormavivaMmoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def game(conn, %{"name" => username}) do
    put_session(conn, :username, username) |> render("game.html")
  end

  def game(conn, %{}) do
    if get_session(conn, :username) do
      render(conn, "game.html")
    else
      put_session(conn, :username, FormavivaMmo.Utils.generate_username())
      |> render("game.html")
    end
  end

  def move(conn, %{"movement" => movement}) do
    render(conn, "game.html")
  end
end
