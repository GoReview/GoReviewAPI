defmodule Goreviewapi.Usuarios.Create do
  alias Goreviewapi.{Error, Usuario, Repo}

  def call(params) do
    params
    |> Usuario.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Usuario{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
