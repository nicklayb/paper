defmodule Paper.ArticleContent do
  use Paper, :schema

  alias Paper.{Article}

  schema "article_contents" do
    field :locale, :string
    field :title, :string
    field :body, :string
    field :slug, :string

    belongs_to :article, Article

    timestamps()
  end

  @required ~w(locale title)a
  @optional ~w(body)a
  def changeset(article, params) do
    article
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> put_slug()
  end

  def put_slug(%Ecto.Changeset{} = changeset) do
    title = get_change(changeset, :title)
    if (title) do
      put_change(changeset, :slug, title_to_slug(title))
    else
      changeset
    end
  end

  def title_to_slug(title) do
    title
    |> String.downcase
    |> String.normalize(:nfd)
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
