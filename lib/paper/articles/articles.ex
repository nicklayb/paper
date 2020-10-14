defmodule Paper.Articles do
  use Paper, :context

  alias Paper.{Repo, Article}

  @preloads ~w(author article_contents)a
  @spec create(map()) :: {:ok, %Article{}}
  def create(params \\ %{}) do
    %Article{}
    |> Article.changeset(params)
    |> Repo.insert()
    |> preload(@preloads)
  end

  @spec update(%Article{}, map()) :: {:ok, %Article{}}
  def update(%Article{} = article, params \\ %{}) do
    article
    |> Article.changeset(params)
    |> Repo.update()
    |> preload(@preloads)
  end

  @spec list() :: [%Article{}]
  def list do
    Article
    |> Repo.all()
    |> Repo.preload(@preloads)
  end

  @spec change(%Article{}) :: Ecto.Changeset.t()
  def change(article \\ %Article{}) do
    Article.changeset(article, %{})
  end

  @spec new() :: Ecto.Changeset.t()
  def new() do
    Article.changeset(
      %Article{},
      %{article_contents: [%{locale: "fr", title: "Nouvel article"}]}
    )
  end

  def preload({:ok, %Article{} = article}, preloads) do
    {:ok, Repo.preload(article, preloads)}
  end
end
