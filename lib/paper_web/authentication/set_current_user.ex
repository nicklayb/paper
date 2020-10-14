defmodule PaperWeb.Authentication.SetCurrentUser do
  import Plug.Conn

  def init(_) do
  end

  def call(conn, _) do
    assign(conn, :current_user, PaperWeb.Authentication.Plug.current_resource(conn))
  end
end
