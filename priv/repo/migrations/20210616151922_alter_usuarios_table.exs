defmodule Goreviewapi.Repo.Migrations.AlterUsuariosTable do
  use Ecto.Migration

  def change do
    alter table :usuarios do
      add :avatar_url, :string
    end
  end
end
