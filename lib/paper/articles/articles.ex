defmodule Paper.Articles do
  use Paper, :context

  alias Paper.{Repo, Article}

  @spec create(map()) :: {:ok, %Article{}} | {:error, Ecto.Changeset.t()}
  def create(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @spec update(%Article{}, map()) :: {:ok, %Article{}} | {:error, Ecto.Changeset.t()}
  def update(%Article{} = article, attrs \\ %{}) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @spec get(integer()) :: %Article{}
  def get(id) do
    Article
    |> Repo.get(id)
  end

  @spec list() :: [%Article{}]
  def list do
    Article
    |> Repo.all()
    |> preload()
  end

  @spec change(%Article{}, map()) :: Ecto.Changeset.t()
  def change(article \\ %Article{}, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end

  @spec new() :: Ecto.Changeset.t()
  def new() do
    change(%Article{}, %{
      article_contents: [%{locale: "fr", title: "Nouvel article"}]
    })
  end

  @preloads ~w(author article_contents)a
  @spec preload(%Article{} | [%Article{}]) :: %Article{} | [%Article{}]
  def preload(articles) do
    Repo.preload(articles, @preloads)
  end
end
