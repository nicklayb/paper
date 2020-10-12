defmodule PaperWeb.Authentication.Controller do
  use Phoenix.Controller
  alias Paper.Users
  alias PaperWeb.Authentication
  alias PaperWeb.Router.Helpers, as: Routes

  plug Ueberauth

  def new(conn, _) do
    render(
      conn,
      "new.html",
      changeset: Users.change()
    )
  end

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.authentication_path(conn, :new))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Users.get_or_register(auth) do
      {:ok, user} ->
        conn
        |> Authentication.log_in(user)
        |> redirect(to: Routes.user_path(conn, :index))
      {:error, _error_changeset} ->
        conn
        |> put_flash(:error, "Authentication failed.")
        |> redirect(to: Routes.authentication_path(conn, :new))
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _}} = conn, _params) do
    conn
    |> put_flash(:error, "Authentication failed.")
    |> redirect(to: Routes.authentication_path(conn, :new))
  end
end
