defmodule Goreviewapi.Desafios.Update do
  alias Goreviewapi.{Error, Desafio, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Desafio, id) do
      nil -> {:error, Error.build_desafio_not_found_error()}
      desafio -> do_update(desafio, params)
    end
  end

  def call(%{}), do: {:error, Error.build(:bad_request, "ID required")}

  defp do_update(desafio, params) do
    desafio
    |> Desafio.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Desafio{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
