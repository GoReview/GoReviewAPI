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
end
