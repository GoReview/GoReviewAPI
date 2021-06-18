defmodule Goreviewapi.Revisores.Delete do
  alias Goreviewapi.{Error, Revisor, Repo}

  def call(id) do
    case Repo.get(Revisor, id) do
      nil -> {:error, Error.build_revisor_not_found_error()}
      revisor -> delete_revisor(revisor)
    end
  end

  defp delete_revisor(param) do
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
