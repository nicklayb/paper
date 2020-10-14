defmodule Paper.Repo.Migrations.CreateArticleTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :author_id, references(:users, on_delete: :nilify_all), null: false

      timestamps()
    end

    create table(:article_contents) do
      add :article_id, references(:articles, on_delete: :delete_all), null: false
      add :locale, :string
      add :title, :string
      add :body, :text
      add :slug, :string
      add :published_at, :naive_datetime
      add :archived_at, :naive_datetime

      timestamps()
    end

    create index(:articles, [:author_id])
    create unique_index(:article_contents, [:article_id, :locale])
  end
end
