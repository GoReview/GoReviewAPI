defmodule GoreviewapiWeb.DesafiosController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Desafio
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, %Desafio{} = desafio} <- Goreviewapi.create_desafio(params) do
      conn
      |> put_status(:created)
      |> render("create.json", desafio: desafio)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Desafio{}} <- Goreviewapi.delete_desafio_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, %{"id" => id}) do
    with {:ok, %Desafio{} = desafio} <- Goreviewapi.get_desafio_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("desafio.json", desafio: desafio)
    end
  end

  def show_class(conn, %{"id" => id}) do
    with {:ok, [%Desafio{} | _rest] = desafio} <- Goreviewapi.get_desafio_by_class(id) do
      conn
      |> put_status(:ok)
      |> render("desafio.json", desafio: desafio)
    end
  end

  def show_list(conn, _params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, desafio} <- Goreviewapi.get_desafio() do
      conn
      |> put_status(:ok)
      |> render("desafio.json", desafio: desafio)
    end
  end

  def update(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, %Desafio{} = desafio} <- Goreviewapi.update_desafio(params) do
      conn
      |> put_status(:ok)
      |> render("desafio_update.json", desafio: desafio)
    end
  end
end
