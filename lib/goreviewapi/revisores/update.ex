defmodule Goreviewapi.Revisores.Update do
  alias Goreviewapi.{Error, Revisor, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Revisor, id) do
      nil -> {:error, Error.build_revisor_not_found_error()}
      revisor -> do_update(revisor, params)
    end
  end

  defp do_update(desafio, params) do
    desafio
    |> Revisor.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Revisor{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
