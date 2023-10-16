defmodule Elixirgist.Repo do
  use Ecto.Repo,
    otp_app: :elixirgist,
    adapter: Ecto.Adapters.Postgres
end
