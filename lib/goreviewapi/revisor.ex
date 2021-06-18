defmodule Goreviewapi.Revisor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Comentario, Usuario, Envio}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params []

  @derive {Jason.Encoder, only: @required_params++[:nota]} #REVER ISSO AQUI

  schema "revisores" do
    field :nota, :integer

    has_many :comentario, Comentario
    belongs_to :usuario, Usuario
    belongs_to :envio, Envio

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params)
  end

  def changeset(struct, params) do
    struct
    |> changes(params, @required_params)
  end

  defp changes(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
  end
end
