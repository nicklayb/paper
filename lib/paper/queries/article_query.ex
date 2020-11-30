defmodule Paper.Queries.ArticleQuery do
  use Paper.Queries.Query

  def preload(query) do
    preload(query, [:author, :article_contents])
  end
end
