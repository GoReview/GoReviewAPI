defmodule Goreviewapi.Usuarios.Get do
  import Ecto.Query

  alias Goreviewapi.{Error, Usuario, Repo}

  def by_id(id) do
    case Repo.get(Usuario, id) do
      nil -> {:error, Error.build_usuario_not_found_error()}
      usuario -> {:ok, usuario}
    end
  end

  def by_email(%{"email" => email}) do
    query = from(usuario in Usuario, where: usuario.email == ^email)

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  def by_email(_), do: {:error, Error.build(:bad_request, "Invalid Params")}

  def get_all do
    query =
      from(usuario in Usuario,
        select: [:id, :name, :group, :avatar_url]
      )

    case Repo.all(query) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      usuario -> {:ok, usuario}
    end
  end

  defp handle_result([]), do: {:error, Error.build_usuario_not_found_error()}

  defp handle_result([result]), do: {:ok, result}
end
