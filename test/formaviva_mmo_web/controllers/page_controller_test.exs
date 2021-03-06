defmodule FormavivaMmoWeb.PageControllerTest do
  use FormavivaMmoWeb.ConnCase

  test "GET /game?name", %{conn: conn} do
    conn = get(conn, "/game?name=test")
    assert html_response(conn, 200) =~ "Playing as: test"
  end
end
