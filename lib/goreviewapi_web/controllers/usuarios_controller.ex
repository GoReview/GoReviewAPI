defmodule GoreviewapiWeb.UsuariosController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.{Email, Usuario}
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Usuario{id: id, name: name, group: group, email: email} = usuario} <-
           Goreviewapi.create_user(params),
         {:ok, token, _claims} <-
           Guardian.encode_and_sign(id, %{group: group}, ttl: {30, :minute}) do
      Email.send_welcome_email(name, email, id)

      conn
      |> put_status(:created)
      |> render("create.json", token: token, usuario: usuario)
    end
  end

  def delete(conn, _params) do
    with {:ok, logged_usuario} <- Guardian.current_usuario(conn),
         {:ok, %Usuario{}} <- Goreviewapi.delete_user(logged_usuario) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, _params) do
    with {:ok, logged_usuario} <- Guardian.current_usuario(conn),
         {:ok, %Usuario{} = usuario} <- Goreviewapi.get_user_by_id(logged_usuario) do
      conn
      |> put_status(:ok)
      |> render("usuario.json", usuario: usuario)
    end
  end

  def show_list(conn, _params) do
    with {:ok, usuario} <- Goreviewapi.get_users() do
      conn
      |> put_status(:ok)
      |> render("usuario.json", usuario: usuario)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def update(conn, params) do
    with {:ok, logged_usuario} <- Guardian.current_usuario(conn) do
      params = Map.put(params, "id", logged_usuario)

      with {:ok, %Usuario{} = usuario} <- Goreviewapi.update_user(params) do
        conn
        |> put_status(:ok)
        |> render("usuario.json", usuario: usuario)
      end
    end
  end

  def reset(conn, params) do
    with {:ok, %Usuario{id: id, name: name, email: email}} <-
           Goreviewapi.get_user_by_email(params),
         {:ok, _usuario} <- Goreviewapi.reset_password(id, name, email) do
      conn
      |> put_status(:ok)
      |> render("senha.json", email: email)
    end
  end
end
