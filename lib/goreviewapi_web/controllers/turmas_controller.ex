defmodule GoreviewapiWeb.TurmasController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Turma
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
         {:ok, %Turma{} = turma} <- Goreviewapi.create_turma(params) do
      conn
      |> put_status(:created)
      |> render("create.json", turma: turma)
    end
  end

  # def list_por_aluno...

  # def index(conn, id) do...

  def show_list(conn, _params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
         {:ok, turma} <- Goreviewapi.get_turma() do
      conn
      |> put_status(:ok)
      |> render("turma.json", turma: turma)
    end
  end

  def update(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
         {:ok, %Turma{} = turma} <- Goreviewapi.update_turma(params) do
      conn
      |> put_status(:ok)
      |> render("turma_update.json", turma: turma)
    end
  end
end
