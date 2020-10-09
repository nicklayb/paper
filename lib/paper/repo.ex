defmodule Paper.Repo do
  use Ecto.Repo,
    otp_app: :paper,
    adapter: Ecto.Adapters.Postgres
end
