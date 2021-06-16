defmodule Goreviewapi.Repo.Migrations.CreateEnviosTable do
  use Ecto.Migration

  def change do
    create table(:envios) do
      add :arquivo, :string
      add :dono_nota, :decimal

      add :usuario_id, references(:usuarios, type: :binary_id)
      add :desafio_id, references(:desafios, type: :binary_id)
      timestamps()
    end
  end
end
