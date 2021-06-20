defmodule Goreviewapi.Desafios.Get do
  import Ecto.Query

  alias Goreviewapi.{Error, Desafio, Repo}

  def by_id(id) do
    case Repo.get(Desafio, id) |> Desafio.preload_assoc() do
      nil -> {:error, Error.build_desafio_not_found_error()}
      desafio -> {:ok, desafio}
    end
  end

  def by_class(id) do
    query =
      from(desafio in Desafio,
        join: turma in assoc(desafio, :turma),
        where: turma.id == ^id,
        preload: [:envio]
      )

    case Repo.all(query) |> Desafio.preload_assoc() do
      [] ->
        {:error, Error.build(:not_found, "Desafio not associated to any Turma")}

      turma ->
        {:ok, turma}
    end
  end

  def get_all do
    query =
      from(desafio in Desafio,
        select: [:id, :titulo, :descricao, :data_envio, :data_revisao, :turma_id],
        preload: [:envio]
      )

    case Repo.all(query) |> Desafio.preload_assoc() do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      desafio -> {:ok, desafio}
    end
  end
end
