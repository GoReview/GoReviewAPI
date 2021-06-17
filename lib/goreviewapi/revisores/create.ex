defmodule Goreviewapi.Revisores.Create do
  alias Goreviewapi.{Error, Revisor, Repo}

  def call(params) do
    params
    |> Revisor.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Revisor{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
