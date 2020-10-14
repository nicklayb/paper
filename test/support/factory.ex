defmodule Paper.Factory do
  use ExMachina.Ecto, repo: Paper.Repo

  alias Paper.ArticleContent

  def user_factory do
    %Paper.User{
      first_name: "Richard",
      last_name: "Hendricks",
      email: "richard@piedpieper.com"
    }
  end

  def article_factory do
    %Paper.Article{
      author: build(:user),
      article_contents: build_list(2, :article_content)
    }
  end

  def article_content_factory do
    title = Faker.Lorem.sentence()
    %Paper.ArticleContent{
      locale: sequence(:locale, ["en", "fr"]),
      title: title,
      body: Faker.Lorem.paragraph(),
      slug: ArticleContent.title_to_slug(title),
    }
  end
end
