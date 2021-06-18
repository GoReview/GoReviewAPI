defmodule Goreviewapi.Usuarios.Delete do
  alias Goreviewapi.{Error, Usuario, Repo}

  def call(id) do
    case Repo.get(Usuario, id) do
      nil -> {:error, Error.build_usuario_not_found_error()}
      usuario -> delete_usuario(usuario)
    end
  end

  defp delete_usuario(param) do
    param
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.no_assoc_constraint(:turmas)
    |> Repo.delete()
    |> handle_delete()
  end

  defp handle_delete({:ok, result}), do: {:ok, result}

  defp handle_delete({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
