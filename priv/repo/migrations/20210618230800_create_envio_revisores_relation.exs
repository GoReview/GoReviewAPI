defmodule Goreviewapi.Repo.Migrations.CreateEnvioRevisoresRelation do
  use Ecto.Migration

  def change do
    alter table :revisores do
      add :envio_id, references(:envios, type: :binary_id)
    end
  end
end
