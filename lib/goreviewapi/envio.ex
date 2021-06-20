defmodule Goreviewapi.Envio do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Repo, Usuario, Desafio, Revisor}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:arquivo, :desafio_id, :usuario_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :dono_nota, :usuario, :revisor]}

  schema "envios" do
    field :arquivo, :string
    field :dono_nota, :decimal

    belongs_to :usuario, Usuario
    belongs_to :desafio, Desafio
    has_many :revisor, Revisor

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params ++ [:dono_nota])
  end

  def changeset(struct, params) do
    struct
    |> changes(params, @required_params ++ [:dono_nota])
  end

  defp changes(struct, params, fields) do
    struct
    |> Repo.preload([:usuario, :revisor])
    |> cast(params, fields)
    |> unique_constraint([:usuario_id_desafio_id])
    |> validate_required(fields)
    |> validate_length(:arquivo, min: 1)
    |> validate_number(:dono_nota, greater_than_or_equal_to: 0)
  end
end
