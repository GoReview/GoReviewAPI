defmodule GoreviewapiWeb.Auth.Guardian do
  use Guardian, otp_app: :goreviewapi

  alias Goreviewapi.{Error, Usuario}
  alias Goreviewapi.Usuarios.Get, as: UsuarioGet

  def subject_for_token(usuario_id, _claims) do
    {:ok, usuario_id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UsuarioGet.by_id()
  end

  def atual_token(conn) do
    Guardian.Plug.current_token(conn)
  end

  def current_usuario(conn) do
    conn
    |> atual_token()
    |> decode_and_verify()
    |> handle_usuario()
  end

  defp handle_usuario({:ok, %{"sub" => logged_usuario}}), do: {:ok, logged_usuario}

  defp handle_usuario({:error, _result}),
    do: {:error, Error.build(:unauthorized, "Access not allowed")}

  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %Usuario{password_hash: hash, id: usuario_id}} <-
           UsuarioGet.by_email(%{"email" => email}),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(usuario_id, ttl: {30, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
