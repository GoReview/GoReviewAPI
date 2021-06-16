defmodule Goreviewapi.Repo.Migrations.CreateComentariosRevisoresRelation do
  use Ecto.Migration

  def change do
    alter table :comentarios do
      add :revisor_id, references(:revisores, type: :binary_id)
  end
end
