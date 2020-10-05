defmodule Article.Repo do
  use Ecto.Repo,
    otp_app: :article,
    adapter: Ecto.Adapters.Postgres
end
