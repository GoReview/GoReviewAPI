defmodule Goreviewapi.Turma do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.Usuario

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :avatar_url]

  @derive {Jason.Encoder, only: @required_params++[:id]}

  schema "turmas" do
    field :name, :string
    field :avatar_url, :string

    many_to_many :usuario, Usuario, join_through: "usuarios_turmas"

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
    |> validate_length(:name, min: 6)
    |> validate_length(:avatar_url, min: 6)
  end
end
