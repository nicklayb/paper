defmodule Paper.ArticlesTest do
  use Paper.DataCase, async: true

  import Paper.Factory

  alias Paper.Articles

  describe "articles" do
    test "create/1 should create an article and return it" do
      params = params_with_assocs(:article)
      assert {:ok, article} = Articles.create(params)
      assert article.author_id
    end

    test "update/1 should update an article and return it" do
      article = insert(:article)
      first_content = Enum.at(article.article_contents, 0)
      article_contents = Enum.map(article.article_contents, fn content ->
        if (content.id) === first_content.id,
          do: %{id: content.id, title: "New Title"},
          else: %{ id: content.id }
      end)

      assert {:ok, updated} =
        Articles.update(
          article,
          %{ article_contents: article_contents }
        )

      first_updated_content = Enum.at(updated.article_contents, 0)
      assert first_updated_content.title == "New Title"
    end
  end
end
