defmodule GoreviewapiWeb.RevisoresController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Revisor
  alias GoreviewapiWeb.Auth.Guardian
  alias GoreviewapiWeb.FallbackController

  action_fallback FallbackController

  def update(conn, params) do
    with {:ok, %{"group" => "professor"}} <- Guardian.verify_claims(conn),
         {:ok, %Revisor{} = revisor} <- Goreviewapi.update_revisor(params) do
      conn
      |> put_status(:ok)
      |> render("revisor_update.json", revisor: revisor)
    end
  end
end
