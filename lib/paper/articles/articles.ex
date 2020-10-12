defmodule Paper.Articles do
  use Paper.Context
  alias Paper.{Repo, Article}

  @spec create(map()) :: {:ok, %Article{}}
  def create(params \\ %{}) do
    %Article{}
    |> Article.changeset(params)
    |> Repo.insert()
  end

  @spec update(%Article{}, map()) :: {:ok, %Article{}}
  def update(%Article{} = article, params \\ %{}) do
    article
    |> Article.changeset(params)
    |> Repo.update()
  end
end
