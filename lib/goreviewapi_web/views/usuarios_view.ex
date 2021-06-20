defmodule GoreviewapiWeb.UsuariosView do
  use GoreviewapiWeb, :view

  alias Goreviewapi.Usuario

  def render("create.json", %{usuario: %Usuario{} = usuario, token: token}) do
    %{
      message: "User Created!",
      usuario: usuario,
      token: token
    }
  end

  def render("senha.json", %{email: email}) do
    %{
      message: "A new password was sent!",
      email: email
    }
  end

  def render("usuario.json", %{usuario: %Usuario{} = usuario}), do: %{usuario: usuario}

  def render("usuario.json", %{usuario: [%Usuario{} | _rest] = usuario}),
    do: %{usuario: usuario}

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
