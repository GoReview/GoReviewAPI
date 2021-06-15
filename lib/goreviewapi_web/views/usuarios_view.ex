defmodule GoreviewapiWeb.UsuariosView do
  use GoreviewapiWeb, :view

  alias Goreviewapi.Usuario

  def render("create.json", %{usuario: %Usuario{} = usuario}) do
    %{
      message: "User Created!",
      usuario: usuario
    }
  end

  def render("usuario.json", %{usuario: %Usuario{} = usuario}), do: %{usuario: usuario}
end
