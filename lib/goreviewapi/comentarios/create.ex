defmodule Goreviewapi.Comentarios.Create do
  alias Goreviewapi.{Error, Comentario, Repo}

  def call(params) do
    params
    |> Comentario.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Comentario{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
