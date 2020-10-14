defmodule Paper.ArticleTest do
  use Paper.DataCase, async: true

  import Paper.Factory

  alias Paper.ArticleContent

  describe "article_content" do
    test "title_to_slug/1 should slufigy a string" do

      assert "the-internet-we-deserve" == ArticleContent.title_to_slug("The internet we deserve")
      assert "linternet-que-lon-merite" == ArticleContent.title_to_slug("L'internet que l'on mérite")
    end
  end
end
