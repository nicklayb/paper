defmodule PaperWeb.Authentication.ErrorHandler do
  use Phoenix.Controller
  alias PaperWeb.Router.Helpers, as: Routes

  @behaviour Guardian.Plug.ErrorHandler
  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason} = error, _opts) do
    IO.inspect(error)
    conn
    |> put_flash(:error, "Authentication error.")
    |> redirect(to: Routes.authentication_path(conn, :new))
  end
end
