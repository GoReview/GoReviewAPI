defmodule GoreviewapiWeb.TurmasController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Turma
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, %Turma{} = turma} <- Goreviewapi.create_turma(params) do
      conn
      |> put_status(:created)
      |> render("create.json", turma: turma)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Turma{}} <- Goreviewapi.delete_turma_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, %{"id" => id}) do
    with {:ok, %Turma{} = turma} <- Goreviewapi.get_turma_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("turma.json", turma: turma)
    end
  end

  def show_user(conn, %{"id" => id}) do
    with {:ok, [%Turma{} | _rest] = turma} <- Goreviewapi.get_turma_by_user(id) do
      conn
      |> put_status(:ok)
      |> render("turma.json", turma: turma)
    end
  end

  def show_list(conn, _params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, turma} <- Goreviewapi.get_turma() do
      conn
      |> put_status(:ok)
      |> render("turma.json", turma: turma)
    end
  end

  def update(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_teacher(conn),
         {:ok, %Turma{} = turma} <- Goreviewapi.update_turma(params) do
      conn
      |> put_status(:ok)
      |> render("turma_update.json", turma: turma)
    end
  end
end
