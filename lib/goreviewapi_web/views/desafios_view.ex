defmodule GoreviewapiWeb.DesafiosView do
  use GoreviewapiWeb, :view

  alias Goreviewapi.Desafio

  def render("create.json", %{desafio: %Desafio{} = desafio}) do
    %{
      message: "Desafio Created!",
      desafio: desafio
    }
  end

  def render("desafio_update.json", %{desafio: %Desafio{} = desafio}) do
    %{
      message: "Desafio Updated!",
      desafio: desafio
    }
  end

  def render("desafio.json", %{desafio: %Desafio{} = desafio}), do: %{desafio: desafio}

  def render("desafio.json", %{desafio: [%Desafio{} | _rest] = desafio}), do: %{desafios: desafio}
end
