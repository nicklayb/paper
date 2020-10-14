defmodule PaperWeb.Router do
  use PaperWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug(:put_root_layout, {PaperWeb.Layouts.View, :root})
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug PaperWeb.Authentication.Pipeline
    plug PaperWeb.Authentication.SetCurrentUser
  end

  scope "/", PaperWeb do
    pipe_through [:browser]

    get "/", Authentication.Controller, :new, as: "authentication"
    get "/auth/:provider", Authentication.Controller, :request, as: "authentication"
    get "/auth/:provider/callback", Authentication.Controller, :callback, as: "authentication"
  end

  scope "/", PaperWeb do
    pipe_through [:browser, :authenticated]

    get "/users", Users.Controller, :index, as: "users"
    get "/articles", Articles.Controller, :index, as: "articles"
    get "/articles/new", Articles.Controller, :new, as: "articles"
    post "/articles", Articles.Controller, :create, as: "articles"
    delete "/logout", Authentication.Controller, :delete, as: "authentication"

    live "/light", LightLive
  end
end
