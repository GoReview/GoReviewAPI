defmodule Goreviewapi.Turma do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Repo, Desafio, Usuario}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :avatar_url]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :usuario, :desafio]}

  schema "turmas" do
    field :name, :string
    field :avatar_url, :string

    many_to_many :usuario, Usuario,
      join_through: "usuarios_turmas",
      on_delete: :delete_all,
      on_replace: :delete

    has_many :desafio, Desafio

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params)
  end

  def changeset(struct, params, alunos) do
    struct
    |> changes(params, @required_params, alunos)
  end

  def preload_assoc(struct), do: struct |> Repo.preload([:usuario, desafio: [envio: [:usuario, :revisor]]])

  defp changes(struct, params, fields, alunos) do
    struct
    |> preload_assoc()
    |> cast(params, fields)
    |> validate_required(fields)
    |> put_assoc(:usuario, alunos)
    |> validate_length(:name, min: 6)
    |> validate_length(:avatar_url, min: 6)
  end

  defp changes(struct, params, fields) do
    struct
    |> preload_assoc()
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:name, min: 6)
    |> validate_length(:avatar_url, min: 6)
  end
end
