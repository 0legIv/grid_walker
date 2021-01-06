defmodule GridWalkerWeb.Router do
  use GridWalkerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GridWalkerWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/game", GameController, :create
    post "/game/operation", GameController, :operation
    get "/game", GameController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GridWalkerWeb do
  #   pipe_through :api
  # end
end
