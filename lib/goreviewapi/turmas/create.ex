defmodule Goreviewapi.Turmas.Create do
  alias Goreviewapi.{Error, Turma, Repo}

  def call(params) do
    params
    |> Turma.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Turma{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
