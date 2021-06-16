defmodule Goreviewapi.Repo.Migrations.CreateRevisoresTable do
  use Ecto.Migration

  def change do
    create table(:revisores) do
      add :nota, :decimal

      add :usuario_id, references(:usuarios, type: :binary_id)
      timestamps()
    end
  end
end
