defmodule Goreviewapi.Desafio do
  use Ecto.Schema
  import Ecto.Changeset

  alias Goreviewapi.{Repo, Turma, Envio}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:titulo, :descricao, :data_envio, :data_revisao, :turma_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :envio]}

  schema "desafios" do
    field :titulo, :string
    field :descricao, :string
    field :data_envio, :date
    field :data_revisao, :date

    belongs_to :turma, Turma
    has_many :envio, Envio, foreign_key: :desafio_id, references: :id

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params)
  end

  def changeset(struct, params) do
    struct
    |> changes(params, @required_params ++ [:id])
  end

  def preload_assoc(struct), do: struct |> Repo.preload([:envio])

  defp changes(struct, params, fields) do
    struct
    |> preload_assoc()
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:titulo, min: 6)
    |> validate_length(:descricao, min: 6)
  end
end
