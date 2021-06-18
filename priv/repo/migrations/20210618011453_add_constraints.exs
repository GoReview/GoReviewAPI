defmodule Goreviewapi.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def change do
    create unique_index(:usuarios_turmas, [:usuario_id, :turma_id])
    create unique_index(:envios, [:usuario_id, :desafio_id])
  end
end
