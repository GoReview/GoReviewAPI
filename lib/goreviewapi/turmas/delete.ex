defmodule Goreviewapi.Turmas.Delete do
  alias Goreviewapi.{Error, Turma, Repo}

  def call(id) do
    case Repo.get(Turma, id) do
      nil -> {:error, Error.build_turma_not_found_error()}
      turma -> delete_turma(turma)
    end
  end

  defp delete_turma(param) do
    param
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.no_assoc_constraint(:usuario)
    |> Repo.delete()
    |> handle_delete()
  end

  defp handle_delete({:ok, result}), do: {:ok, result}

  defp handle_delete({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
