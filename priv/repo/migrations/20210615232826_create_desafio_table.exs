defmodule Goreviewapi.Repo.Migrations.CreateDesafioTable do
  use Ecto.Migration

  def change do
    create table(:desafios) do
      add :titulo, :string
      add :descricao, :string
      add :data_envio, :date
      add :data_revisao, :date

      add :turma_id, references(:turmas, type: :binary_id)
      timestamps()
    end

  end
end
