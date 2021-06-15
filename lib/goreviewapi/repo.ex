defmodule Goreviewapi.Repo do
  use Ecto.Repo,
    otp_app: :goreviewapi,
    adapter: Ecto.Adapters.Postgres
end
