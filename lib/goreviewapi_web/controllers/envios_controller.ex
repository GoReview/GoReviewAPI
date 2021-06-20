defmodule GoreviewapiWeb.EnviosController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Envio
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    # verify aluno, sei la
    with {:ok, %{"group" => "aluno"}} <- Guardian.verify_pupil(conn),
         {:ok, %Envio{} = envio} <- Goreviewapi.create_envio(params) do
      conn
      |> put_status(:created)
      |> render("create.json", envio: envio)
    end
  end

  def update(conn, params) do
    # arrumar aqui, ta livre
    with {:ok, %Envio{} = envio} <- Goreviewapi.update_envio(params) do
      conn
      |> put_status(:ok)
      |> render("envio_update.json", envio: envio)
    end
  end

  def show_list(conn, _params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, envio} <- Goreviewapi.get_envio() do
      conn
      |> put_status(:ok)
      |> render("envio.json", envio: envio)
    end
  end
end
