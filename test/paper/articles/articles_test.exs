defmodule Paper.ArticlesTest do
  use Paper.DataCase, async: true

  import Paper.Factory

  alias Paper.Articles

  describe "articles" do
    test "create/1 should create an article and return it" do
      params = params_with_assocs(:article)
      assert {:ok, article} = Articles.create(params)
      assert article.title_en == params.title_en
      assert article.author_id
    end

    test "update/1 should update an article and return it" do
      article = insert(:article)
      assert {:ok, updated} = Articles.update(article, params_for(:article, %{title_en: "A different title!"}))
      assert updated.title_en != article.title_en
    end
  end
end
