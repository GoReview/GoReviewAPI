defmodule GoreviewapiWeb.TurmasView do
  use GoreviewapiWeb, :view

  alias Goreviewapi.Turma

  def render("create.json", %{turma: %Turma{} = turma}) do
    %{
      message: "Turma Created!",
      turma: turma,
    }
  end

  def render("turma.json", %{turma: %Turma{} = turma}), do: %{turma: turma}

  def render("turma.json", %{turma: [%Turma{} | _rest] = turma}),do: %{turmas: turma}

end
