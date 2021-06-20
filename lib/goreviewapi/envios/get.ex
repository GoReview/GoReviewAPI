defmodule Goreviewapi.Envio.Get do
  import Ecto.Query

  alias Goreviewapi.{Error, Envio, Repo}

  def by_id(id) do
    case Repo.get(Envio, id) do
      nil -> {:error, Error.build_envio_not_found_error()}
      envio -> {:ok, envio}
    end
  end

  def get_all do
    query =
      from(envio in Envio,
        select: [:id, :name],
        preload: [:usuario]
      )

    case Repo.all(query) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      envio -> {:ok, envio}
    end
  end
end
