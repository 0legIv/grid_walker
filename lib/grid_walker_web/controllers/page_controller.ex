defmodule GridWalkerWeb.PageController do
  use GridWalkerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
