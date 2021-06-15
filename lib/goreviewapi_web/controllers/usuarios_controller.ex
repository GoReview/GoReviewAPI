defmodule GoreviewapiWeb.UsuariosController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Usuario
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Usuario{} = usuario} <-
           Goreviewapi.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", usuario: usuario)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Usuario{}} <- Goreviewapi.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, %{"id" => id}) do
    with {:ok, %Usuario{} = usuario} <- Goreviewapi.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("usuario.json", usuario: usuario)
    end
  end

  def email(conn, %{"email" => email}) do
    with {:ok, %Usuario{} = usuario} <- Goreviewapi.get_user_by_email(email) do
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

  def update(conn, params) do
    with {:ok, %Usuario{} = usuario} <- Goreviewapi.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("usuario.json", usuario: usuario)
    end
  end
end
