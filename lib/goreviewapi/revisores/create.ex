defmodule Goreviewapi.Revisores.Create do
  alias Goreviewapi.{Error, Revisor, Repo}

  def call(params) do
    params
    |> Revisor.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def call_sorteado(%{usuario_id: usuario_id, envio_id: envio_id}) do
    #vou deixar isso aqui, mas em um caso real o melhor seria procedure
    {:ok, %{rows: revisor_ids}} = Repo.query(
      ~s{select us.id from envios en
      left join desafios de on de.id = en.desafio_id
      left join turmas tu on tu.id = de.turma_id
      left join usuarios_turmas ut on tu.id = ut.turma_id
      inner join usuarios us on ut.usuario_id = us.id and us.id <> en.usuario_id
      where en.id = '#{envio_id}'}
    )
    revisor_id = Enum.random(revisor_ids)

    call(%{
      revisor_id: revisor_id,
      usuario_id: usuario_id,
      envio_id: envio_id
    })
  end

  defp handle_insert({:ok, %Revisor{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
