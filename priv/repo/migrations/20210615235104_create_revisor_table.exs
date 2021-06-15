defmodule Goreviewapi.Repo.Migrations.CreateRevisorTable do
  use Ecto.Migration

  def change do
    create table(:revisor) do
      add :nota, :decimal

      add :usuario_id, references(:usuarios, type: :binary_id)
      timestamps()
    end
  end
end
