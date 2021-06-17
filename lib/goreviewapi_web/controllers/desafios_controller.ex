defmodule GoreviewapiWeb.DesafiosController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Desafio
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
    {:ok, %Desafio{} = desafio} <- Goreviewapi.create_desafio(params) do
    conn
    |> put_status(:created)
    |> render("create.json", desafio: desafio)
    end
  end

  def update(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
         {:ok, %Desafio{} = desafio} <- Goreviewapi.update_desafio(params) do
      conn
      |> put_status(:ok)
      |> render("desafio_update.json", desafio: desafio)
    end
  end
end
