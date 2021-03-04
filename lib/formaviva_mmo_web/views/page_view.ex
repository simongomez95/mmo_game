defmodule FormavivaMmoWeb.PageView do
  use FormavivaMmoWeb, :view

  def current_user(conn) do
    Plug.Conn.get_session(conn, :username)
  end

end
