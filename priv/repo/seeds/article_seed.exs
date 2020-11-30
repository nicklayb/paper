defmodule ArticleSeed do
  import Ecto.Query, only: [from: 2]
  alias Paper.{Repo, Articles, User}

  def random_user do
    query =
      from User,
      order_by: fragment("RANDOM()"),
      limit: 1

    Repo.one(query)
  end

  def seed() do
    Enum.map(1..10, fn n ->
      {:ok, article} = seed_article(%{
        author_id: random_user().id,
        article_contents: [
          %{
            locale: "en",
            title: "Generated Article - #{n}",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
          },
          %{
            locale: "fr",
            title: "Article généré - #{n}",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
          }
        ]
      })
    end)
  end

  def seed_article(params) do
    Articles.create(params)
  end
end
