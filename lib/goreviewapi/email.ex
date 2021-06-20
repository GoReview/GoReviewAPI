defmodule Goreviewapi.Email do
  import Bamboo.Email

  alias Goreviewapi.Mailer

  def send_welcome_email(name, email, id) do
    welcome_email(name, email, id)
    |> Mailer.deliver_later()
  end

  def send_reset_email(name, email, new_pass) do
    reset_email(name, email, new_pass)
    |> Mailer.deliver_later()
  end

  defp welcome_email(name, email, id) do
    new_email(
      to: email,
      from: "goreviewapp@gmail.com",
      subject: "Bem vindo ao GoReview",
      text_body:
        "Olá, #{name}\nBem vindo a sua plataforma de correções!\nSeu ID é #{id}.\nUse seu e-mail e senha cadastrados para fazer login.\nhttp://goreviewapp.vercel.com/"
    )
  end

  defp reset_email(name, email, new_pass) do
    new_email(
      to: email,
      from: "goreviewapp@gmail.com",
      subject: "GoReview - Redefinição de Senha",
      text_body:
        "Olá, #{name}\nSua senha foi redefinida!\nSua nova senha é #{new_pass}\nUse seu e-mail e a nova senha para fazer login.\nhttp://goreviewapp.vercel.com/"
    )
  end
end
