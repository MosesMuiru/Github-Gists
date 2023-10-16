defmodule Elixirgist.Repo.Migrations.CreateSavedGist do
  use Ecto.Migration

  def change do
    create table(:saved_gist, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :gist_id, references(:gist, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:saved_gist, [:user_id])
    create index(:saved_gist, [:gist_id])
  end
end
