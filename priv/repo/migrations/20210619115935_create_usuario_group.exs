defmodule Goreviewapi.Repo.Migrations.CreateUsuarioGroup do
  use Ecto.Migration

  def change do

    up_query = "CREATE TYPE usuario_group as ENUM ('admin', 'professor', 'aluno')"
    down_query = "DROP TYPE usuario_group"

    execute(up_query, down_query)

  end
end
