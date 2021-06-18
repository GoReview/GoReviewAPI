defmodule Goreviewapi.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Envio, Turma}

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :group, :password, :name, :avatar_url]
  @update_params [:email, :group, :password, :name, :avatar_url]

  @derive {Jason.Encoder, only: [:id, :name, :group]}

  schema "usuarios" do
    field :name, :string
    field :email, :string
    field :group, :string
    field :avatar_url, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :envio, Envio
    many_to_many :turmas, Turma, join_through: "usuarios_turmas"

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params)
  end

  def changeset(struct, params) do
    struct
    |> changes(params, @update_params)
  end

  defp changes(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:name, min: 2)
    |> validate_length(:group, min: 2)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
