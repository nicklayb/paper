defmodule PaperWeb.ArticleView do
  use PaperWeb, :view

  def get_title(article) do
    Enum.at(article.article_contents, 0).title
  end
end
