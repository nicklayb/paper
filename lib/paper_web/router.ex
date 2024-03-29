defmodule PaperWeb.Router do
  use PaperWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug(:put_root_layout, {PaperWeb.LayoutView, :root})
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

    delete "/logout", AuthenticationController, :delete

    live "/users", UserLive.Index, :index
    live "/articles", ArticleLive.Index, :index
    live "/articles/new", ArticleLive.Index, :new
    live "/articles/:id/edit", ArticleLive.Edit, :edit
  end
end
