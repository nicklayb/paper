defmodule Paper.Repo.Migrations.CreateArticleTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title_en, :string
      add :title_fr, :string
      add :body_en, :text
      add :body_fr, :text
      add :slug_en, :string
      add :slug_fr, :string
      add :published_at, :naive_datetime
      add :archived_at, :naive_datetime

      add :author_id, references(:users, on_delete: :nilify_all), null: false

      timestamps()
    end

    create index(:users, [:id])
  end
end
