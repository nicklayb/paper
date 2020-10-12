defmodule PaperWeb.User.Controller do
  use Phoenix.Controller

  plug(:put_view, PaperWeb.User.View)

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, _) do
    render(conn, "index.html")
  end
end
