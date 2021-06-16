defmodule Goreviewapi.Comentario do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Envio, Revisor}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:texto, :linha]

  @derive {Jason.Encoder, only: @required_params} #REVER ISSO AQUI

  schema "comentarios" do
    field :texto, :string
    field :linha, :string

    belongs_to :envio, Envio
    belongs_to :revisor, Revisor

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
    |> validate_length(:texto, min: 6)
    |> validate_number(:linha, min: 0)
  end

end
