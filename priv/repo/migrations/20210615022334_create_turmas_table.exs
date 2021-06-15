defmodule Goreviewapi.Repo.Migrations.CreateTurmasTable do
  use Ecto.Migration

  def change do
    create table(:turmas) do
      add :name, :string
      add :avatar_url, :string

      timestamps()
    end
  end
end
