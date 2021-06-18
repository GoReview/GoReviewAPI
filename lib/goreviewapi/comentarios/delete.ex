defmodule Goreviewapi.Comentarios.Delete do
  alias Goreviewapi.{Error, Comentario, Repo}

  def call(id) do
    case Repo.get(Comentario, id) do
      nil -> {:error, Error.build_comentario_not_found_error()}
      comentario -> delete_comentario(comentario)
    end
  end

  defp delete_comentario(param) do
    param
    |> Ecto.Changeset.change()
    |> Repo.delete()
    |> handle_delete()
  end

  defp handle_delete({:ok, result}), do: {:ok, result}

  defp handle_delete({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
