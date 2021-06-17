defmodule Goreviewapi.Desafios.Get do
  import Ecto.Query

  alias Goreviewapi.{Error, Desafio, Repo}

  def by_id(id) do
    case Repo.get(Desafio, id) do
      nil -> {:error, Error.build_desafio_not_found_error()}
      desafio -> {:ok, desafio}
    end
  end

  def get_all do
    query =
      from(desafio in Desafio,
        select: [:id, :name]
      )

    case Repo.all(query) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      desafio -> {:ok, desafio}
    end
  end
end
