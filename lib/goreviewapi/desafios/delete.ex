defmodule Goreviewapi.Desafios.Delete do
  alias Goreviewapi.{Error, Desafio, Repo}

  def call(id) do
    case Repo.get(Desafio, id) do
      nil -> {:error, Error.build_desafio_not_found_error()}
      desafio -> delete_desafio(desafio)
    end
  end

  defp delete_desafio(param) do
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
