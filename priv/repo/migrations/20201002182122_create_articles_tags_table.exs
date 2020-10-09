defmodule Paper.Repo.Migrations.CreateArticlesTagsTable do
  use Ecto.Migration

  def change do
    create table(:articles_tags) do
      add :article_id, references(:articles)
      add :tag_id, references(:tags)

      timestamps()
    end
    create unique_index(:articles_tags, [:article_id, :tag_id])
  end
end
