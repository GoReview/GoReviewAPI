defmodule GoreviewapiWeb.WelcomeController do
  use GoreviewapiWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("GoReview API - Time Ignautas - teste")
  end
end
