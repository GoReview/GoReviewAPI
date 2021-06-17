defmodule Goreviewapi.Desafios.Create do
  alias Goreviewapi.{Error, Desafio, Repo}

  def call(params) do
    params
    |> Desafio.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Desafio{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
