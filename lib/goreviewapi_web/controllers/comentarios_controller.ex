defmodule GoreviewapiWeb.ComentariosController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Comentario
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, %Comentario{} = comentario} <- Goreviewapi.create_comentario(params) do
      conn
      |> put_status(:created)
      |> render("create.json", comentario: comentario)
    end
  end

  def update(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, %Comentario{} = comentario} <- Goreviewapi.update_comentario(params) do
      conn
      |> put_status(:ok)
      |> render("comentario_update.json", comentario: comentario)
    end
  end
end
