defmodule GoreviewapiWeb.FallbackController do
  use GoreviewapiWeb, :controller

  alias Goreviewapi.Error
  alias GoreviewapiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", %{result: result})
  end

  #Parece que é isso que acontece quando retona 401
  def call(conn, {_, %{}}) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render("error.json", %{result: "Forrbiden"})
  end
end
