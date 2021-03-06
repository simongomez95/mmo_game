defmodule FormavivaMmoWeb.Router do
  use FormavivaMmoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FormavivaMmoWeb do
    pipe_through :browser

    get "/", PageController, :game
    get "/game", PageController, :game
    post "/move", PageController, :move
    get "/move", PageController, :game
  end
end
