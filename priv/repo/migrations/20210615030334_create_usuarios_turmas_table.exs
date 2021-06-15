defmodule Goreviewapi.Repo.Migrations.CreateUsuariosTurmasTable do
  use Ecto.Migration

  def change do
    create table(:usuarios_turmas, primary_key: false) do
      add :usuario_id, references(:usuarios, type: :binary_id)
      add :turma_id, references(:turmas, type: :binary_id)
    end
  end
end
