defmodule PaperWeb.UserController do
  use PaperWeb, :controller

  alias Paper.Users

  def index(conn, _, _) do
    render(conn, "index.html", users: Users.list())
  end
end
