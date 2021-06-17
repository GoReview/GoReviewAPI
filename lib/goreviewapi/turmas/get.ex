defmodule Goreviewapi.Turmas.Get do
  import Ecto.Query

  alias Goreviewapi.{Error, Turma, Repo}

  def by_id(id) do
    case Repo.get(Usuario, id) do
      nil -> {:error, Error.build_turma_not_found_error()}
      turma -> {:ok, turma}
    end
  end

  def get_all do
    query =
      from(turma in Turma,
        select: [:id, :name]
      )

    case Repo.all(query) |> Repo.preload([:usuario, :desafio]) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      turma -> {:ok, turma}
    end
  end
end
