defmodule FormavivaMmo.Repo do
  use Ecto.Repo,
    otp_app: :formaviva_mmo,
    adapter: Ecto.Adapters.Postgres
end
