defmodule GoreviewapiWeb.TurmasController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Turma
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with  {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
          {:ok, %Turma{id: _id} = turma} <- Goreviewapi.create_turma(params)
         do
      conn
      |> put_status(:created)
      |> render("create.json", turma: turma)
    end
  end
end