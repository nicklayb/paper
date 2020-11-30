defmodule Paper.Article do
  use Paper, :schema

  alias Paper.{Article, ArticleContent, User}

  schema "articles" do
    belongs_to :author, User, foreign_key: :author_id
    has_many :article_contents, ArticleContent

    timestamps()
  end

  @required ~w(author_id)a
  @spec changeset(%Article{}, map()) :: Ecto.Changeset.t()
  def changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> cast_assoc(:article_contents, required: true)
  end
end
