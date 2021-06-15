defmodule Goreviewapi.Turmas.Update do
  alias Goreviewapi.{Error, Turma, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Turma, id) do
      nil -> {:error, Error.build_turma_not_found_error()}
      turma -> do_update(turma, params)
    end
  end

  defp do_update(turma, params) do
    turma
    |> Turma.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Turma{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
