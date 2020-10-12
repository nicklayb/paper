defmodule PaperWeb.Router do
  use PaperWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(:put_layout, {PaperWeb.Layouts.View, :app})
  end

  pipeline :authenticated do
    plug PaperWeb.Authentication.Pipeline
  end

  scope "/", PaperWeb do
    pipe_through [:browser]

    get "/", Authentication.Controller, :new, as: "authentication"
    get "/auth/:provider", Authentication.Controller, :request, as: "authentication"
    get "/auth/:provider/callback", Authentication.Controller, :callback, as: "authentication"
  end

  scope "/", PaperWeb do
    pipe_through [:browser, :authenticated]

    get "/users", User.Controller, :index, as: "user"
    delete "/logout", Authentication.Controller, :delete, as: "authentication"
  end
end
