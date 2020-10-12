defmodule PaperWeb.Authentication do
  @moduledoc """
  Implementation module for Guardian and functions for authentication.
  """
  use Guardian, otp_app: :paper
  alias Paper.{User, Users}

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Users.get(id)
    {:ok, user}
  end

  def log_in(conn, user) do
    __MODULE__.Plug.sign_in(conn, user)
  end

  def log_out(conn) do
    __MODULE__.Plug.sign_out(conn)
  end

  def get_current_user(conn) do
    __MODULE__.Plug.current_resource(conn)
  end
end
