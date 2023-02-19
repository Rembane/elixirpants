defmodule ElixirpantsWeb.PageController do
  use ElixirpantsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
