defmodule Paper.Repo.Migrations.CreateArticleTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title_en, :string
      add :body_en, :string
      add :title_fr, :string
      add :body_fr, :string
      add :author_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:users, [:id])
  end
end
