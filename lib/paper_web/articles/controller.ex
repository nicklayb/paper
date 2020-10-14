defmodule PaperWeb.Articles.Controller do
  use PaperWeb, :controller

  alias Paper.Articles

  plug(:put_view, PaperWeb.Articles.View)

  def index(conn, _, _) do
    render(conn, "index.html", articles: Articles.list())
  end

  def new(conn, _, _) do
    render(conn, "new.html", changeset: Articles.new())
  end

  def create(conn, %{"article" => article}, current_user) do
    article = Map.put(article, "author_id", current_user.id)

    with {:ok, _article} <- Articles.create(article) do
      conn
      |> put_flash(:success, "Bravo champion! 🥇")
      |> redirect(to: Routes.articles_path(conn, :index))
    end
  end
end
