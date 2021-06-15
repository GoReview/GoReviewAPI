defmodule Goreviewapi.Repo.Migrations.CreateUsuariosTable do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :name, :string
      add :email, :string
      add :group, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:usuarios, [:email])
  end
end
