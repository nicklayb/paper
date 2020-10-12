defmodule PaperWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :paper,
    error_handler: PaperWeb.Authentication.ErrorHandler,
    module: PaperWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
