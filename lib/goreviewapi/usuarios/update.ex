defmodule Goreviewapi.Usuarios.Update do
  alias Goreviewapi.{Error, Usuario, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Usuario, id) do
      nil -> {:error, Error.build_usuario_not_found_error()}
      usuario -> do_update(usuario, params)
    end
  end

  defp do_update(usuario, params) do
    usuario
    |> Usuario.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Usuario{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
