defmodule Paper.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias Paper.User

  schema "articles" do
    field(:title_en, :string)
    field(:title_fr, :string)
    field(:body_en, :string)
    field(:body_fr, :string)
    field(:slug_en, :string)
    field(:slug_fr, :string)

    belongs_to(:author, User, foreign_key: :author_id)

    timestamps()
  end

  @required ~w(author_id)a
  @optional ~w(title_en title_fr body_en body_fr slug_en slug_fr)a
  def changeset(article, params) do
    article
    |> cast(params, @optional ++ @required)
    |> validate_required(@required)
  end

  def title_to_slug(title) do
    title
    |> String.downcase
    |> String.normalize(:nfd)
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
