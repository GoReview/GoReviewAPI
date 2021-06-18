defmodule Goreviewapi.Turmas.Update do
  alias Goreviewapi.{Error, Turma, Repo, Usuario}
  import Ecto.Query

  def call(%{"id" => id} = params) do
    case Repo.get(Turma, id) do
      nil -> {:error, Error.build_turma_not_found_error()}
      turma ->
        fetch_alunos(params)#do_update(turma, params)
        |> do_update(turma, params)
    end
  end

  defp do_update(alunos, turma, params) do
    turma
    |> Turma.changeset(params, alunos)
    |> Repo.update()
    |> handle_update()
  end

  #nesse caso seria um array de ids
  defp fetch_alunos(%{"alunos" => alunos_ids}) do
    query = from aluno in Usuario, where: aluno.id in ^alunos_ids and aluno.group == "aluno"

    query
    |> Repo.all()
    |> IO.inspect()
  end

  defp handle_update({:ok, %Turma{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
