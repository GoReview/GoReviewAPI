defmodule Goreviewapi do
  alias Goreviewapi.Usuarios.Create, as: UserCreate
  alias Goreviewapi.Usuarios.Get, as: UserGet
  alias Goreviewapi.Usuarios.Delete, as: UserDelete
  alias Goreviewapi.Usuarios.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate get_user_by_email(mail), to: UserGet, as: :by_email
  defdelegate get_users, to: UserGet, as: :get_all
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call

  alias Goreviewapi.Turmas.Create, as: TurmaCreate
  alias Goreviewapi.Turmas.Update, as: TurmaUpdate
  alias Goreviewapi.Turmas.Get, as: TurmaGet

  defdelegate create_turma(params), to: TurmaCreate, as: :call
  defdelegate update_turma(params), to: TurmaUpdate, as: :call
  defdelegate get_turma_by_id(id), to: TurmaGet, as: :by_id
  defdelegate get_turma, to: TurmaGet, as: :get_all

  alias Goreviewapi.Desafios.Create, as: DesafioCreate
  alias Goreviewapi.Desafios.Update, as: DesafioUpdate
  #alias Goreviewapi.Desafios.Delete, as: DesafioDelete
  #alias Goreviewapi.Desafios.Get, as: DesafioGet

  defdelegate create_desafio(params), to: DesafioCreate, as: :call
  defdelegate update_desafio(params), to: DesafioUpdate, as: :call
  #
  #
  #defdelegate get_desafio, to: DesafioGet, as: :get_all

  alias Goreviewapi.Envios.Create, as: EnvioCreate
  alias Goreviewapi.Envios.Update, as: EnvioUpdate
  alias Goreviewapi.Revisores.Update, as: RevisorUpdate

  defdelegate create_envio(params), to: EnvioCreate, as: :call
  defdelegate update_envio(params), to: EnvioUpdate, as: :call
  defdelegate update_revisor(params), to: RevisorUpdate, as: :call

  alias Goreviewapi.Comentarios.Create, as: ComentarioCreate
  alias Goreviewapi.Comentarios.Update, as: ComentarioUpdate
  alias Goreviewapi.Comentarios.Delete, as: ComentarioDelete

  defdelegate create_comentario(params), to: ComentarioCreate, as: :call
  defdelegate update_comentario(params), to: ComentarioUpdate, as: :call
  defdelegate delete_comentario(id), to: ComentarioDelete, as: :call
end
