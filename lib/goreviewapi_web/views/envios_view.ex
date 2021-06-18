defmodule GoreviewapiWeb.EnviosView do
  use GoreviewapiWeb, :view

  alias Goreviewapi.Envio

  def render("create.json", %{envio: %Envio{} = envio}) do
    %{
      message: "Envio Created!",
      envio: envio
    }
  end

  def render("envio_update.json", %{envio: %Envio{} = envio}) do
    %{
      message: "Envio Updated!",
      envio: envio
    }
  end

  def render("envio.json", %{envio: %Envio{} = envio}), do: %{envio: envio}

  def render("envio.json", %{envio: [%Envio{} | _rest] = envio}), do: %{envios: envio}
end
