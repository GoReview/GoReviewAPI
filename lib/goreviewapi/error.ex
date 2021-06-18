defmodule Goreviewapi.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_desafio_not_found_error, do: build(:not_found, "Desafio not found")
  def build_envio_not_found_error, do: build(:not_found, "Envio not found")
  def build_usuario_not_found_error, do: build(:not_found, "Usuario not found")
  def build_turma_not_found_error, do: build(:not_found, "Turma not found")
  def build_revisor_not_found_error, do: build(:not_found, "Revisor not found")
end
