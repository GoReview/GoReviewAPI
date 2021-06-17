defmodule Goreviewapi.Envios.Update do
  alias Goreviewapi.{Error, Envio, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Envio, id) do
      nil -> {:error, Error.build_envio_not_found_error()}
      envio -> do_update(envio, params)
    end
  end

  defp do_update(envio, params) do
    envio
    |> Envio.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Envio{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
