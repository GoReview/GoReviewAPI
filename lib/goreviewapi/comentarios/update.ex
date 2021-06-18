defmodule Goreviewapi.Comentarios.Update do
  alias Goreviewapi.{Error, Comentario, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Comentario, id) do
      nil -> {:error, Error.build_comentario_not_found_error()}
      comentario -> do_update(comentario, params)
    end
  end

  defp do_update(comentario, params) do
    comentario
    |> Comentario.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Comentario{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
