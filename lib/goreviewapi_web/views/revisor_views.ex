defmodule GoreviewapiWeb.RevisoresView do
  use GoreviewapiWeb, :view

  alias Goreviewapi.Revisor

  def render("create.json", %{revisor: %Revisor{} = revisor}) do
    %{
      message: "Revisor Created!",
      revisor: revisor
    }
  end

  def render("revisor_update.json", %{revisor: %Revisor{} = revisor}) do
    %{
      message: "Revisor Updated!",
      revisor: revisor
    }
  end

  def render("revisor.json", %{revisor: %Revisor{} = revisor}), do: %{revisor: revisor}

  def render("revisor.json", %{revisor: [%Revisor{} | _rest] = revisor}), do: %{revisors: revisor}
end
