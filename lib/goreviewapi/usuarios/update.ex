defmodule Goreviewapi.Usuarios.Update do
  alias Goreviewapi.{Email, Error, Usuario, Repo}

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

  def reset_pass(id, name, email) do
    pass = SecureRandom.urlsafe_base64()

    params = %{
      "password" => pass
    }

    Email.send_reset_email(name, email, pass)

    Repo.get(Usuario, id)
    |> do_update(params)
  end

  defp handle_update({:ok, %Usuario{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
