defmodule ArticleWeb.PageController do
  use ArticleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
