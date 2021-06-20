defmodule Goreviewapi.Envios.Create do
  alias Goreviewapi.{Error, Envio, Repo}

  def call(params) do
    params
    |> Envio.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Envio{id: id}} = result) do
    Goreviewapi.Revisores.Create.call_sorteado(id)
    result
  end


  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
