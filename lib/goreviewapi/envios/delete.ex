defmodule Goreviewapi.Envios.Delete do
  alias Goreviewapi.{Error, Envio, Repo}

  def call(id) do
    case Repo.get(Envio, id) do
      nil -> {:error, Error.build_envio_not_found_error()}
      envio -> delete_envio(envio)
    end
  end

  defp delete_envio(param) do
    param
    |> Ecto.Changeset.change()
    |> Repo.delete()
    |> handle_delete()
  end

  defp handle_delete({:ok, result}), do: {:ok, result}

  defp handle_delete({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
