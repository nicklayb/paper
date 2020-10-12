defmodule Paper.Factory do
  use ExMachina.Ecto, repo: Paper.Repo

  def user_factory do
    %Paper.User{
      first_name: "Richard",
      last_name: "Hendricks",
      email: "richard@piedpieper.com"
    }
  end

  def article_factory do
    %Paper.Article{
      title_en: "The internet we deserve",
      title_fr: "L'internet que l'on mérite",
      body_en: Faker.Lorem.paragraph(),
      body_fr: Faker.Lorem.paragraph(),
      author: build(:user)
    }
  end
end
