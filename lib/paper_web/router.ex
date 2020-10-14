defmodule PaperWeb.Router do
  use PaperWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug(:put_root_layout, {PaperWeb.LayoutView, :root})
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug PaperWeb.Authentication.Pipeline
    plug PaperWeb.Authentication.SetCurrentUser
  end

  scope "/", PaperWeb do
    pipe_through [:browser]

    get "/", AuthenticationController, :new
    get "/auth/:provider", AuthenticationController, :request
    get "/auth/:provider/callback", AuthenticationController, :callback
  end

  scope "/", PaperWeb do
    pipe_through [:browser, :authenticated]

    get "/users", UserController, :index
    get "/articles", ArticleController, :index
    get "/articles/new", ArticleController, :new
    post "/articles", ArticleController, :create
    delete "/logout", AuthenticationController, :delete

    live "/light", LightLive
  end
end
