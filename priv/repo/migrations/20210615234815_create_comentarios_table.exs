defmodule Goreviewapi.Repo.Migrations.CreateComentariosTable do
  use Ecto.Migration

  def change do
    create table(:comentarios) do
      add :texto, :string
      add :linha, :integer

      add :envio_id, references(:envios, type: :binary_id)
      timestamps()
    end
  end
end
