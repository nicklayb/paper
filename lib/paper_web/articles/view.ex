defmodule PaperWeb.Articles.View do
  use PaperWeb, :view
  use Phoenix.View, root: "lib/paper_web", path: "articles/templates", namespace: PaperWeb

  def get_title(article) do
    Enum.at(article.article_contents, 0).title
  end
end
