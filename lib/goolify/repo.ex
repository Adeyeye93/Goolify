defmodule Goolify.Repo do
  use Ecto.Repo,
    otp_app: :goolify,
    adapter: Ecto.Adapters.Postgres
end
