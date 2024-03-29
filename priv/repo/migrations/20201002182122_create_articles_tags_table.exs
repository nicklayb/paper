defmodule Paper.Repo.Migrations.CreateArticlesTagsTable do
  use Ecto.Migration

  def change do
    create table(:articles_tags) do
      add :article_id, references(:articles, on_delete: :delete_all), null: false
      add :tag_id, references(:tags, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:articles_tags, [:article_id, :tag_id])
  end
end
