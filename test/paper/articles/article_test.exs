defmodule Paper.ArticleTest do
  use Paper.DataCase, async: true

  import Paper.Factory

  alias Paper.Article

  describe "article" do
    test "title_to_slug/1 should slufigy a string" do

      assert "the-internet-we-deserve" == Article.title_to_slug("The internet we deserve")
      assert "linternet-que-lon-merite" == Article.title_to_slug("L'internet que l'on mérite")
    end
  end
end
