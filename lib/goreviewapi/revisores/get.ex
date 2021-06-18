defmodule Goreviewapi.Revisores.Get do
  import Ecto.Query

  alias Goreviewapi.{Error, Revisor, Repo}

  def by_id(id) do
    case Repo.get(Revisor, id) do
      nil -> {:error, Error.build_revisor_not_found_error()}
      revisor -> {:ok, revisor}
    end
  end

  def get_all do
    query =
      from(revisor in Revisor,
        select: [:id, :name]
      )

    case Repo.all(query) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      revisor -> {:ok, revisor}
    end
  end
end
