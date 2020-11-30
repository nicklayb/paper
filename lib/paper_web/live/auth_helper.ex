defmodule PaperWeb.Live.AuthHelper do
  @moduledoc "Helpers to assist with loading the user from the session into the socket"
  @claims %{"typ" => "access"}
  @token_key "guardian_default_token"

  def load_user(%{@token_key => token}) do
    case Guardian.decode_and_verify(PaperWeb.Authentication, token, @claims) do
      {:ok, claims} ->
        PaperWeb.Authentication.resource_from_claims(claims)
      _ ->
        {:error, :not_authorized}
    end
  end
  def load_user(_), do: {:error, :not_authorized}
end
