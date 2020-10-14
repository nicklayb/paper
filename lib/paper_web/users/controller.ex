defmodule PaperWeb.Users.Controller do
  use PaperWeb, :controller

  alias Paper.Users

  plug :put_view, PaperWeb.Users.View

  def index(conn, _, _) do
    render(conn, "index.html", users: Users.list())
  end
end
