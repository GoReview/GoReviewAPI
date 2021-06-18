defmodule Goreviewapi.Envio do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Repo ,Usuario, Desafio}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:arquivo, :desafio_id]

  @derive {Jason.Encoder, only: @required_params++[:dono_nota, :usuario]}

  schema "envios" do
    field :arquivo, :string
    field :dono_nota, :decimal

    belongs_to :usuario, Usuario
    belongs_to :desafio, Desafio

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
    |> Repo.preload(:usuario)
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:arquivo, min: 1)
    |> validate_number(:dono_nota, min: 0)
  end

end
